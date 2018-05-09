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


extension UInt
{
	public static func random<T:UnsignedInteger>(inRange range:ClosedRange<T> = 1...6) -> T
	{
		let length = UInt64((range.upperBound - range.lowerBound + 1))
		let value = UInt64(arc4random()) % length + UInt64(range.lowerBound)
		return T(value)
	}
}
