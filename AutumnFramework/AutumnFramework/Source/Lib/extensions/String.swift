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
		return self.characters.count
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
	
	/// Trims whitespace from start and end of string.
	///
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
	
	
	/// - Returns: `true` if contains any cahracters other than whitespace or newline characters, else `no`.
	public var isBlank:Bool
	{
		return trimmed.isEmpty
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
		
		self.init(allowedCharsString.characters.sample(size: length)!)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public func split(_ separator:String) -> [String]
	{
		return self.components(separatedBy: separator)
	}
	
	
	func substring(_ start:Int, _ end:Int = -1) -> String
	{
		let startIndex = self.index(self.startIndex, offsetBy: start)
		let endIndex = self.index(startIndex, offsetBy: end < 0 ? self.characters.count - 2 : end)
		return self.substring(from: startIndex).substring(to: endIndex)
	}
}
