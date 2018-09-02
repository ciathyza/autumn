/*
 *   __  ____  _ __
 *  / / / / /_(_) /__
 * / /_/ / __/ / (_-<
 * \____/\__/_/_/___/
 *
 * Utils & Extensions for Swiift Projects..
 * Written by Ciathyza
 */

import Foundation


/// A typealias to keep backwards compatibility with version 2.0.x and 2.1.x.
public typealias Timespan = TimeInterval


extension TimeInterval
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var timeFormatted:String
	{
		if (seconds < 60)
		{
			return String(format: "%ds", seconds)
		}
		if (seconds == 60)
		{
			return String(format: "%dm", minutes)
		}
		return String(format: "%dm %02ds", minutes, seconds)
	}
	
	public var minutes:Int
	{
		return Int((self / 60).truncatingRemainder(dividingBy: 60))
	}
	
	public var seconds:Int
	{
		return Int(truncatingRemainder(dividingBy: 60))
	}
	
	public var milliseconds:Int
	{
		return Int((self * 1000).truncatingRemainder(dividingBy: 1000))
	}
	
	internal static var secondsPerDay:Double
	{
		return 24 * 60 * 60
	}
	internal static var secondsPerHour:Double
	{
		return 60 * 60
	}
	internal static var secondsPerMinute:Double
	{
		return 60
	}
	internal static var millisecondsPerSecond:Double
	{
		return 1_000
	}
	internal static var microsecondsPerSecond:Double
	{
		return 1_000 * 1_000
	}
	internal static var nanosecondsPerSecond:Double
	{
		return 1_000 * 1_000 * 1_000
	}
	
	/// - Returns: The `TimeInterval` in days.
	public var days:Double
	{
		return self / TimeInterval.secondsPerDay
	}
	
	/// - Returns: The `TimeInterval` in hours.
	public var hours:Double
	{
		return self / TimeInterval.secondsPerHour
	}
	
	/// - Returns: The `TimeInterval` in minutes.
	public var mins:Double
	{
		return self / TimeInterval.secondsPerMinute
	}
	
	/// - Returns: The `TimeInterval` in seconds.
	public var secs:Double
	{
		return self
	}
	
	/// - Returns: The `TimeInterval` in milliseconds.
	public var ms:Double
	{
		return self * TimeInterval.millisecondsPerSecond
	}
	
	/// - Returns: The `TimeInterval` in microseconds.
	public var microseconds:Double
	{
		return self * TimeInterval.microsecondsPerSecond
	}
	
	/// - Returns: The `TimeInterval` in nanoseconds.
	public var nanoseconds:Double
	{
		return self * TimeInterval.nanosecondsPerSecond
	}
	
	// MARK: - Type Methods
	/// - Returns: The time in days using the `TimeInterval` type.
	public static func days(_ value:Double) -> TimeInterval
	{
		return value * secondsPerDay
	}
	
	
	/// - Returns: The time in hours using the `TimeInterval` type.
	public static func hours(_ value:Double) -> TimeInterval
	{
		return value * secondsPerHour
	}
	
	
	/// - Returns: The time in minutes using the `TimeInterval` type.
	public static func minutes(_ value:Double) -> TimeInterval
	{
		return value * secondsPerMinute
	}
	
	
	/// - Returns: The time in seconds using the `TimeInterval` type.
	public static func seconds(_ value:Double) -> TimeInterval
	{
		return value
	}
	
	
	/// - Returns: The time in milliseconds using the `TimeInterval` type.
	public static func milliseconds(_ value:Double) -> TimeInterval
	{
		return value / millisecondsPerSecond
	}
	
	
	/// - Returns: The time in microseconds using the `TimeInterval` type.
	public static func microseconds(_ value:Double) -> TimeInterval
	{
		return value / microsecondsPerSecond
	}
	
	
	/// - Returns: The time in nanoseconds using the `TimeInterval` type.
	public static func nanoseconds(_ value:Double) -> TimeInterval
	{
		return value / nanosecondsPerSecond
	}
}
