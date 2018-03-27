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


extension Int
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	/// Returns a seconds conversion of a milliseconds integer value.
	///
	public var msToSeconds:Double
	{
		return Double(self) / 1000
	}
	
	/**
	 * Returns a date with the value of self as the Unix timestamp.
	 */
	public var toDate:Date
	{
		return Date(timeIntervalSince1970: Double(self))
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	/// Initializes a new `Int ` instance with a random value below a given `Int`.
	///
	/// - Parameters:
	///   - randomBelow: The upper bound value to create a random value with.
	///
	public init?(randomBelow upperLimit:Int)
	{
		guard upperLimit > 0 else
		{
			return nil
		}
		self.init(arc4random_uniform(UInt32(upperLimit)))
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public static func random<T:SignedInteger>(inRange range:ClosedRange<T> = 1...6) -> T
	{
		let length = Int64((range.upperBound - range.lowerBound + 1))
		let value = Int64(arc4random()) % length + Int64(range.lowerBound)
		return T(value)
	}
	
	
	/// Runs the code passed as a closure the specified number of times.
	///
	/// - Parameters:
	///   - closure: The code to be run multiple times.
	///
	public func times(_ closure:() -> Void)
	{
		guard self > 0 else
		{
			return
		}
		for _ in 0..<self
		{
			closure()
		}
	}
}
