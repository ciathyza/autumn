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


class StopWatch
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var milliseconds:TimeInterval { return seconds * 1000 }
	public private(set) var seconds:TimeInterval = 0
	public var minutes:TimeInterval { return seconds / 60 }
	
	private weak var timer:Timer?
	private var startTime:TimeInterval = 0
	private var started:Bool { return timer != nil }
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public func start()
	{
		if started { return }
		
		startTime = Date().timeIntervalSinceReferenceDate
		timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true)
		{
			timer in
			self.seconds = Date().timeIntervalSinceReferenceDate - self.startTime
			DispatchQueue.main.async
			{
			}
		}
	}
	
	
	public func stop()
	{
		if !started { return }
		timer!.invalidate()
		timer = nil
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Class Methods
	// ----------------------------------------------------------------------------------------------------
	
	public class func secondsToHoursMinutesSeconds(seconds:Int) -> (Int, Int, Int)
	{
		return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
	}
	
	
	public class func secondsToHoursMinutesSeconds(seconds:Double) -> (Int, Int, Int)
	{
		let (hr, minf) = modf(seconds / 3600)
		let (min, secf) = modf(60 * minf)
		return (Int(hr), Int(min), Int(60 * secf))
	}
	
	
	public class func secondsToMilliseconds(seconds:Double) -> UInt
	{
		return UInt(seconds * 1000)
	}
}
