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


extension Dictionary
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/// Initializes a new `Dictionary` and fills it with keys and values arrays.
	///
	/// - Parameters:
	///   - keys:       The `Array` of keys.
	///   - values:     The `Array` of values.
	///
	public init?(keys:[Key], values:[Value])
	{
		guard keys.count == values.count else
		{
			return nil
		}
		self.init()
		for (index, key) in keys.enumerated()
		{
			self[key] = values[index]
		}
	}
	
	
	/// Merge given `Dictionary` into this `Dictionary` overriding existing values for matching keys.
	///
	/// - Parameters:
	///   - otherDictionary:    The other `Dictionary` to merge into this `Dictionary`.
	///
	public mutating func merge(_ other:[Key:Value])
	{
		for (key, value) in other
		{
			self[key] = value
		}
	}
	
	
	/// Create new merged `Dictionary` with the given `Dictionary` merged into this `Dictionary`
	/// overriding existing values for matching keys.
	///
	/// - Parameters:
	///   - otherDictionary:    The other `Dictionary` to merge into this `Dictionary`.
	/// - Returns: The new Dictionary with merged keys and values from this and the other `Dictionary`.
	///
	public func merged(with other:[Key:Value]) -> [Key:Value]
	{
		var newDict:[Key:Value] = [:]
		[self, other].forEach
		{
			dict in
			for (key, value) in dict
			{
				newDict[key] = value
			}
		}
		return newDict
	}
}
