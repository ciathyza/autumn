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


/**
 * A util class that can be used to measure time duration precisely.
 */
public class ExecutionTimer
{
	// ------------------------------------------------------------------------------------------------
	// Properties
	// ------------------------------------------------------------------------------------------------
	
	public private(set) var duration:TimeInterval = 0.0
	private var _date = Date()
	
	
	// ------------------------------------------------------------------------------------------------
	// Derived Properties
	// ------------------------------------------------------------------------------------------------
	
	public var milliseconds:Int
	{
		return Int((duration * 1000).truncatingRemainder(dividingBy: 1000))
	}
	
	public var seconds:Int
	{
		return Int((duration).truncatingRemainder(dividingBy: 60))
	}
	
	var minutes:Int
	{
		return Int((duration / 60).truncatingRemainder(dividingBy: 60))
	}
	
	var hours:Int
	{
		return Int((duration / 3600).truncatingRemainder(dividingBy: 60))
	}
	
	var days:Int
	{
		return Int((duration / 86400).truncatingRemainder(dividingBy: 60))
	}
	
	var time:String
	{
		return "\(days)d \(hours)h \(minutes)m \(seconds)s \(milliseconds)ms"
	}
	
	var timePretty:String
	{
		if days > 0 { return "\(days)d \(hours)h \(minutes)m \(seconds)s" }
		else if hours > 0 { return "\(hours)h \(minutes)m \(seconds)s" }
		else if minutes > 0 { return "\(minutes)m \(seconds)s" }
		return "\(seconds)s"
	}
	
	
	// ------------------------------------------------------------------------------------------------
	// Methods
	// ------------------------------------------------------------------------------------------------
	
	public func start()
	{
		_date = Date()
	}
	
	
	public func stop()
	{
		duration = _date.timeIntervalSinceNow * -1
	}
}
