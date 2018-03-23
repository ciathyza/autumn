/*
 *   __  ____  _ __
 *  / / / / /_(_) /__
 * / /_/ / __/ / (_-<
 * \____/\__/_/_/___/
 *
 * Utils & Extensions for Swiift Projects.
 *
 * Written by Ciathyza | ciathyza@ciathyza.com
 * Copyright (c) 2017 Ciathyza All rights reserved.
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
	private var _hasFooter = false
	
	
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
	public init(_ columns:Int, _ sort:Bool = false, _ div:String = " ", _ fill:String = " ", _ rowLeading:String = "", _ colMaxLength:Int = 0, _ header:[String]? = nil, _ hasFooter:Bool = false)
	{
		_div = div
		_fill = fill
		_rowLeading = rowLeading
		_hasFooter = hasFooter
		
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
		var result = ""
		let colCount = _columns.count
		let rowCount = _columns[0].count
		
		if _sort && !_isSorted
		{
			TabularText.sort(&_columns, rowCount, _hasHeader, _hasFooter)
			_isSorted = true
		}
		
		/* Process columns and add padding to strings */
		for c in 0 ..< colCount
		{
			var col = _columns[c]
			let maxLen = _lengths[c]
			
			for r in 0 ..< rowCount
			{
				let str:String = col[r]
				if str.count < maxLen
				{
					if (_hasHeader && r == 0) || (_hasFooter && r == rowCount - 1)
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
		for r in 0 ..< rowCount
		{
			var row = _rowLeading
			for c in 0 ..< colCount
			{
				row = "\(row)\(_columns[c][r])"
				/* Last column does not need a following divider */
				if c < colCount - 1
				{
					row = "\(row)\(_div)"
				}
			}
			
			/* If we have a header we want a nice line dividing the header and the rest */
			if (_hasHeader && r == 0) || (_hasFooter && r == rowCount - 2)
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
		
		return "\(result)"
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
	 * Sorts all the arrays in _columns by using sort indices.
	 */
	private static func sort(_ columns:inout [[String]], _ rowCount:Int, _ hasHeader:Bool, _ hasFooter:Bool)
	{
		var tmpHeader = [String]()
		var tmpFooter = [String]()
		
		/* If the text has headers/footers we don't want those to be sorted so remove them temporarily! */
		if (hasHeader)
		{
			for c in 0 ..< columns.count
			{
				tmpHeader.append(columns[c].remove(at: 0))
			}
		}
		if (hasFooter)
		{
			
			for c in 0 ..< columns.count
			{
				tmpFooter.append(columns[c].remove(at: rowCount - 2))
			}
		}
		
		/* Sort the whole row caboodle ... */
		var indices = columns[0].enumerated().sorted(by: {$0.element < $1.element}).map({$0.offset})
		for c in 0 ..< columns.count
		{
			var col:[String] = columns[c]
			var tmp = [String]()
			for i in 0 ..< col.count
			{
				let index = indices[i]
				tmp.append(col[index])
			}
			columns[c] = tmp
		}

		/* And add back headers and footers if they were removed before */
		if hasHeader
		{
			for c in 0 ..< tmpHeader.count
			{
				columns[c].insert(tmpHeader[c], at:0)
			}
		}
		if hasFooter
		{
			for c in 0 ..< tmpFooter.count
			{
				columns[c].append(tmpFooter[c])
			}
		}
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
