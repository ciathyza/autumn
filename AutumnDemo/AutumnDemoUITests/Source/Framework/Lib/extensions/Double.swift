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


extension Double
{
	/// Rounds the double to decimal places value.
	///
	/// - Parameters:
	/// 	- places: The number of decimal places.
	///
	/// - Returns: the rounded value.
	///
	public func rounded(_ places:Int) -> Double
	{
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}
