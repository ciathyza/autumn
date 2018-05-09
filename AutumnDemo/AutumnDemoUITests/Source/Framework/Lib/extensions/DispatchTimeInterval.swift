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


extension DispatchTimeInterval
{
	/// - Returns: The time in seconds using the`TimeInterval` type.
	public var timeInterval:TimeInterval
	{
		switch self
		{
			case .seconds(let seconds): return Double(seconds)
			case .milliseconds(let milliseconds): return Double(milliseconds) / Timespan.millisecondsPerSecond
			case .microseconds(let microseconds): return Double(microseconds) / Timespan.microsecondsPerSecond
			case .nanoseconds(let nanoseconds): return Double(nanoseconds) / Timespan.nanosecondsPerSecond
			case .never: return TimeInterval.infinity
		}
	}
}
