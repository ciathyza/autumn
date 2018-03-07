/*
 *   __  ____  _ __
 *  / / / / /_(_) /__
 * / /_/ / __/ / (_-<
 * \____/\__/_/_/___/
 *
 * Utils & Extensions for Swiift Projects..
 *
 * Written by Sascha Balkau | ts-balkau.sascha@rakuten.com
 * Copyright (c) 2017 Rakuten, Inc. All rights reserved.
 */

import Foundation


/**
 * Represents a list of strings which are seperated into columns. When creating a
 * new TabularText you specify the number of columns that the TabularText should have
 * and then you add as many strings as there are columns with the add() method. The
 * TabularText class cares about adding spacing to any strings so that they can be
 * easily read in a tabular format. A fixed width font is recommended for the use of
 * the output. The toString() method returns the formatted text result.
 */
public class TabularText
{
	//-----------------------------------------------------------------------------------------
	// Properties
	//-----------------------------------------------------------------------------------------
	
	/**
	 * The width of a text line, in characters before the screen width is reached.
	 * This is used to automatically calculate the column width.
	 */
	private static var _lineWidth = 0
	
	private var _columns:[[String]]
	private var _lengths:[Int]
	private var _div:String
	private var _fill:String
	private var _rowLeading:String
	private var _colMaxLength = 0
	private var _width = 0
	private var _sort:Bool
	private var _isSorted = false
	private var _hasHeader = false
	
	
	//-----------------------------------------------------------------------------------------
	// Derrived Properties
	//-----------------------------------------------------------------------------------------
	
	/**
	 * The text of the TabularText.
	 */
	public var text:String
	{
		return toString();
	}


	/**
	 * The width of the TabularText, in characters. this value should only be checked
	 * after all rows have been added because the width can change depending on
	 * different row lengths.
	 */
	public var width:Int
	{
		return _width;
	}


	//-----------------------------------------------------------------------------------------
	// Init
	//-----------------------------------------------------------------------------------------
	
	/**
	 * Creates a new TabularText instance.
	 *
	 * @param columns the number of columns that the TabularText should have.
	 * @param sort If true the columns are alphabetically sorted.
	 * @param div The String that is used to divide columns visually. If null
	 *        a single whitespace will be used by default.
	 * @param fill An optional String that is used to fill whitespace between
	 *        columns. This string should only be 1 character long. If null a
	 *        whitespace is used as the fill.
	 * @param rowLeading Optional lead characters that any row should start with.
	 * @param colMaxLength If this value is larger than 0, columns will be cropped
	 *        at the length specified by this value. This can be used to prevent
	 *        very long column texts from wrapping to the next line.
	 * @param header An array of header items.
	 */
	public init(_ columns:Int, _ sort:Bool = false, _ div:String = " ", _ fill:String = " ", _ rowLeading:String = "", _ colMaxLength:Int = 0, _ header:[String]? = nil)
	{
		_div = div
		_fill = fill
		_rowLeading = rowLeading
		
		if colMaxLength > 0 { _colMaxLength = colMaxLength }
		else if TabularText._lineWidth > 0 { _colMaxLength = TabularText._lineWidth / columns }
		
		_sort = sort
		_isSorted = false
		
		_columns = [[String]](repeating: [String](), count: columns)
		_lengths = [Int](repeating: 0, count: columns)
		
		if let h = header
		{
			_hasHeader = true
			add(h)
		}
	}
	
	
	//-----------------------------------------------------------------------------------------
	// Public Methods
	//-----------------------------------------------------------------------------------------
	
	/**
	 * Adds a row of Strings to the TabularText.
	 *
	 * @param row A row of strings to add. Every string is part of a column. If there
	 *            are more strings specified than the ColumnText has columns, they are
	 *            ignored.
	 */
	public func add(_ row:[String])
	{
		var l = row.count
		var i = 0
		
		if l > _columns.count
		{
			l = _columns.count
		}
		
		for i in 0 ..< l
		{
			/* We don't store s w/ any rowLeading here yet because it would interfere
			 * with numeric sort, so it gets added instead in toString(). */
			var str:String = "" + row[i]
			
			/* Crop long texts if neccessary */
			if _colMaxLength > 0 && str.count - 3 > _colMaxLength
			{
				let endIndex = str.index(str.startIndex, offsetBy: _colMaxLength - 1)
				str = "\(String(str[..<endIndex]))..."
			}
			
			_columns[i].append(str)
			
			if str.count > _lengths[i]
			{
				_lengths[i] = str.count
			}
		}
		_isSorted = false
		
		/* Re-calculate width */
		_width = 0
		i = 0
		while i < _lengths.count
		{
			_width += _lengths[i]
			i += 1
		}
		_width += _rowLeading.count + (_columns.count - 1) * _div.count
	}
	
	
	/**
	 * Returns a String Representation of the TabularText.
	 *
	 * @return A String Representation of the TabularText.
	 */
	public func toString() -> String
	{
		if _sort && !_isSorted
		{
			TabularText.sort(&_columns, _hasHeader)
			_isSorted = true
		}
		
		var result = ""
		let header = ""
		let cols = _columns.count
		let rows = _columns[0].count
		
		/* Process columns and add padding to strings */
		for c in 0 ..< cols
		{
			var col = _columns[c]
			let maxLen = _lengths[c]
			
			for r in 0 ..< rows
			{
				let str:String = col[r]
				if str.count < maxLen
				{
					if _hasHeader && r == 0
					{
						col[r] = TabularText.pad(str, maxLen, " ")
					}
					else
					{
						col[r] = TabularText.pad(str, maxLen, _fill)
					}
				}
				_columns[c] = col
			}
		}
		
		/* Combine rows */
		for r in 0 ..< rows
		{
			var row = _rowLeading
			for c in 0 ..< cols
			{
				row = "\(row)\(_columns[c][r])"
				/* Last column does not need a following divider */
				if c < cols - 1
				{
					row = "\(row)\(_div)"
				}
			}
			
			/* If we have a header we want a nice line dividing the header and the rest */
			if _hasHeader && r == 0
			{
				row = "\(row)\n\(_rowLeading)"
				var i =  0
				while i < (_width - _rowLeading.length)
				{
					row = "\(row)-"
					i += 1
				}
			}
			
			result = "\(result)\(row)\n"
		}
		
		return "\(header)\(result)"
	}
	
	
	/**
	 * Calculates the text line width for use with automatic column width calculation.
	 *
	 * @param viewWidth
	 * @param charWidth
	 */
	public static func calculateLineWidth(viewWidth:Int, charWidth:Int, offset:Int = 0)
	{
		_lineWidth = (viewWidth / charWidth) - offset
	}
	
	
	//-----------------------------------------------------------------------------------------
	// Private Methods
	//-----------------------------------------------------------------------------------------
	
	/**
	 * Neat little method that sorts all the arrays in _columns by using indices
	 * provided with Array.RETURNINDEXEDARRAY.
	 */
	private static func sort(_ columns:inout [[String]], _ hasHeader:Bool)
	{
	
	}

	
	/**
	 * Ultility method to add whitespace padding to the specified string.
	 */
	private static func pad(_ s:String, _ maxLen:Int, _ fill:String) -> String
	{
		var str = s
		let l = maxLen - s.count
		var i = 0
		while (i < l)
		{
			str += fill
			i += 1
		}
		return str
	}
}
