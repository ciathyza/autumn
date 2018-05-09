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
