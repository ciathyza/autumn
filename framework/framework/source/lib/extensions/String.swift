/*
 *   __  ____  _ __
 *  / / / / /_(_) /__
 * / /_/ / __/ / (_-<
 * \____/\__/_/_/___/
 *
 * Utils & Extensions for Swiift Projects..
 * Written by Sascha Balkau
 */

import Foundation


extension String
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	/// The type of allowed characters.
	///
	/// - Numeric:          Allow all numbers from 0 to 9.
	/// - Alphabetic:       Allow all alphabetic characters ignoring case.
	/// - AlphaNumeric:     Allow both numbers and alphabetic characters ignoring case.
	/// - AllCharactersIn:  Allow all characters appearing within the specified String.
	public enum AllowedCharacters
	{
		case numeric
		case alphabetic
		case alphaNumeric
		case allCharactersIn(String)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var length:Int
	{
		return self.count
	}
	
	public var ns:NSString
	{
		return self as NSString
	}
	
	public var lastPathComponent:String
	{
		return ns.lastPathComponent
	}
	
	public var stringByDeletingPathExtension:String
	{
		return ns.deletingPathExtension
	}
	
	/**
	 * Trims whitespace from start and end of string.
	 */
	public var trimmed:String
	{
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	public var stripped:String
	{
		return components(separatedBy: .whitespaces).joined()
	}
	
	public var isNumber:Bool
	{
		return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
	}
	
	/**
	 * Returns: `true` if contains any cahracters other than whitespace or newline characters, else `no`.
	 */
	public var isBlank:Bool
	{
		return trimmed.isEmpty
	}
	
	/**
	 * Returns: A random character from the `CharacterView` or `nil` if empty.
	 */
	public var sample:Character?
	{
		return isEmpty ? nil : self[index(startIndex, offsetBy: Int(randomBelow: count)!)]
	}
	
	public var obscured:String
	{
		return String(repeating: "*", count: count)
	}
	
	public var toInt:Int
	{
		if let n = Int(self) { return n }
		return 0
	}
	
	public var toUInt:UInt
	{
		if let n = UInt(self) { return n }
		return 0
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	/// Create new instance with random numeric/alphabetic/alphanumeric String of given length.
	///
	/// - Parameters:
	///   - randommWithLength:      The length of the random String to create.
	///   - allowedCharactersType:  The allowed characters type, see enum `AllowedCharacters`.
	///
	public init(randomWithLength length:Int, allowedCharactersType:AllowedCharacters)
	{
		let allowedCharsString:String =
		{
			switch allowedCharactersType
			{
				case .numeric: return "0123456789"
				case .alphabetic: return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
				case .alphaNumeric: return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
				case .allCharactersIn(let allowedCharactersString): return allowedCharactersString
			}
		}()
		
		self.init(allowedCharsString.sample(size: length)!)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/// Returns a given number of random characters from the `CharacterView`.
	///
	/// - Parameters:
	///   - size: The number of random characters wanted.
	/// - Returns: A `CharacterView` with the given number of random characters or `nil` if empty.
	public func sample(size:Int) -> String?
	{
		if isEmpty
		{
			return nil
		}
		
		var sampleElements = String()
		size.times
		{
			sampleElements.append(sample!)
		}
		
		return sampleElements
	}
	
	
	public func split(_ separator:String) -> [String]
	{
		return self.components(separatedBy: separator)
	}
	
	
	public func substr(from:Int, to:Int) -> String
	{
		if count < 1 { return self }
		var fromIndex = from
		var toIndex = to
		
		if fromIndex > toIndex
		{
			let tmp = fromIndex
			fromIndex = toIndex
			toIndex = tmp
		}
		
		fromIndex = fromIndex < 0 ? 0 : fromIndex > count ? count : fromIndex
		toIndex = toIndex > count - 1 ? count - 1 : to < 0 ? 0 : toIndex
		
		let end = (toIndex - self.count) + 1
		let indexStartOfText = self.index(self.startIndex, offsetBy: fromIndex)
		let indexEndOfText = self.index(self.endIndex, offsetBy: end)
		let substring = self[indexStartOfText ..< indexEndOfText]
		return String(substring)
	}
	
	
	public func substr(from:Int) -> String
	{
		return self.substr(from: from, to: self.count - 1)
	}
	
	
	public func substr(to:Int) -> String
	{
		return self.substr(from: 0, to: to)
	}
	
	
	/**
	 * Returns the specified number of chars from the left of the string.
	 */
	public func left(_ to:Int) -> String
	{
		var t = to
		if (t > self.count) { t = self.count }
		else if (t < 0) { t = 0 }
		return "\(self[..<self.index(startIndex, offsetBy: t)])"
	}
	
	
	/**
	 * Returns the specified number of chars from the right of the string.
	 */
	public func right(_ from:Int) -> String
	{
		var f = from
		if (f > self.count) { f = self.count }
		else if (f < 0) { f = 0 }
		return "\(self[self.index(startIndex, offsetBy: self.count - f)...])"
	}
	
	
	/**
	 * Returns the specified number of chars from the given start point of the string.
	 */
	public func mid(_ from:Int, _ count:Int = -1) -> String
	{
		var f = from
		if (f < 0) { f = 0 }
		let x = "\(self[self.index(startIndex, offsetBy: f)...])"
		return x.left(count == -1 ? x.count : count)
	}
	
	
	/**
	 * Returns the substring that is found after the specified search string.
	 */
	public func midAfter(_ search:String, _ count:Int = -1) -> String
	{
		let r = self.range(of: search)
		if (r == nil) { return "" }
		let lb = r!.lowerBound
		let x = "\(self[lb...])".mid(1)
		return x.left(count == -1 ? x.count : count)
	}
	
	
	public func matches(for regex:String) -> [String]
	{
		do
		{
			let regex = try NSRegularExpression(pattern: regex)
			let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
			return results.map
			{
				String(self[Range($0.range, in: self)!])
			}
		}
		catch
		{
			return []
		}
	}
}


extension StringProtocol where Index == String.Index
{
	public func startIndex<T: StringProtocol>(of string:T, options:String.CompareOptions = []) -> Index?
	{
		return range(of: string, options: options)?.lowerBound
	}
	
	
	public func endIndex<T: StringProtocol>(of string:T, options:String.CompareOptions = []) -> Index?
	{
		return range(of: string, options: options)?.upperBound
	}
	
	
	public func indexes<T: StringProtocol>(of string:T, options:String.CompareOptions = []) -> [Index]
	{
		var result:[Index] = []
		var start = startIndex
		while start < endIndex, let range = range(of: string, options: options, range: start..<endIndex)
		{
			result.append(range.lowerBound)
			start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
		}
		return result
	}
	
	
	public func ranges<T: StringProtocol>(of string:T, options:String.CompareOptions = []) -> [Range<Index>]
	{
		var result:[Range<Index>] = []
		var start = startIndex
		while start < endIndex, let range = range(of: string, options: options, range: start..<endIndex)
		{
			result.append(range)
			start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
		}
		return result
	}
}
