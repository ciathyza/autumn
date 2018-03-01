/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import Foundation
import XCTest


/**
 * Delegation methods for XCUITest UI interaction, waiting, and asserts.
 */
public class AutumnUI
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - App
	// ----------------------------------------------------------------------------------------------------
	
	/// Launches the app to running in foreground state.
	///
	public class func launchApp() -> Bool
	{
		AutumnSetup.app.launchArguments = ["--uitesting", "-StartFromCleanState", "YES"]
		AutumnSetup.app.launch()
		let success = AutumnSetup.app.state == .runningForeground
		return success
	}
	
	
	/// Launches the app to running in foreground state.
	///
	public class func activateApp() -> Bool
	{
		AutumnSetup.app.activate()
		let success = AutumnSetup.app.state == .runningForeground
		return success
	}
	
	
	/// Terminates the app.
	///
	public class func terminateApp() -> Bool
	{
		AutumnSetup.app.terminate()
		let success = AutumnSetup.app.state == .notRunning
		return success
	}
	
	
	/// Task-kills the app.
	///
	public class func killApp() -> Bool
	{
		let success = Springboard.killApp(app: AutumnSetup.app)
		return success
	}
	
	
	/// Uninstalls the app.
	///
	public class func uninstallApp() -> Bool
	{
		let success = Springboard.uninstallApp(app: AutumnSetup.app)
		return success
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Wait
	// ----------------------------------------------------------------------------------------------------
	
	/// Same as wait() method but without logging.
	///
	/// - Parameters:
	/// 	- interval: The time to wait in seconds.
	///
	public class func sleep(_ interval:UInt)
	{
		Darwin.sleep(UInt32(interval))
	}
	
	
	/// Waits for x seconds.
	///
	/// - Parameters:
	/// 	- interval: The time to wait in seconds.
	///
	public class func wait(_ interval:UInt)
	{
		sleep(interval)
	}
	
	
	/// Wait for an element to exist and be hittable (visible and onscreen).
	///
	/// - Parameters:
	/// 	- element: Element to wait for.
	/// 	- timeout: Seconds until the wait will time-out as failure.
	///
	/// - Returns: true if element was hittable within time limit, otherwise false.
	///
	public class func waitForHittable(_ element:XCUIElement, skipTelemetry:Bool = false, timeout:UInt = 0) -> Bool
	{
		let clause = "hittable == true"
		let timeout = timeout == 0 ? AutumnSetup.instance.viewPresentTimeout : timeout
		let success = AutumnUI.waitFor(element, clause: clause, skipTelemetry:skipTelemetry, timeout: timeout)
		return success
	}
	
	
	/**
	 * Wait until an element is no longer hittable (might still exist, but is either not visible or not onscreen).
	 *
	 * @param element Element to wait for.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was not hittable within time limit, otherwise false.
	 */
	public class func waitForNotHittable(_ element:XCUIElement, skipTelemetry:Bool = false, timeout:UInt = 0) -> Bool
	{
		let clause = "hittable == false"
		let timeout = timeout == 0 ? AutumnSetup.instance.viewPresentTimeout : timeout
		let success = AutumnUI.waitFor(element, clause: clause, skipTelemetry:skipTelemetry, timeout: timeout)
		return success
	}
	
	
	/**
	 * Wait for an element to exist (does not need to be visible or onscreen).
	 *
	 * @param element Element to wait for.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was found within time limit, otherwise false.
	 */
	public class func waitForExists(_ element:XCUIElement, skipTelemetry:Bool = false, timeout:UInt = 0) -> Bool
	{
		let clause = "exists == true"
		let timeout = timeout == 0 ? AutumnSetup.instance.viewPresentTimeout : timeout
		let success = AutumnUI.waitFor(element, clause: clause, skipTelemetry:skipTelemetry, timeout: timeout)
		return success
	}
	
	
	/**
	 * Wait for an element to not exist anymore.
	 *
	 * @param element Element to wait for.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was not found within time limit, otherwise false.
	 */
	public class func waitForNotExists(_ element:XCUIElement, skipTelemetry:Bool = false, timeout:UInt = 0) -> Bool
	{
		let clause = "exists == false"
		let timeout = timeout == 0 ? AutumnSetup.instance.viewPresentTimeout : timeout
		let success = AutumnUI.waitFor(element, clause: clause, skipTelemetry:skipTelemetry, timeout: timeout)
		return success
	}
	
	
	public class func waitForIsTrue(_ object:NSObject, _ property:String, skipTelemetry:Bool = false, timeout:UInt = 0) -> Bool
	{
		let clause = "\(property) == true"
		let timeout = timeout == 0 ? AutumnSetup.instance.networkLoginTimeout : timeout
		let success = AutumnUI.waitFor(object, clause: clause, skipTelemetry:skipTelemetry, timeout: timeout)
		return success
	}
	
	
	/**
	 * Waits for an element with a specified conditional clause.
	 */
	public class func waitFor(_ element:Any, clause:String, skipTelemetry:Bool = false, timeout:UInt = 0) -> Bool
	{
		let timeout = timeout == 0 ? AutumnSetup.instance.viewPresentTimeout : timeout
		let predicate = NSPredicate(format: clause)
		let expectation = AutumnSetup.instance.expectation(for: predicate, evaluatedWith: element)
		let result = XCTWaiter.wait(for: [expectation], timeout: TimeInterval(timeout))
		
		switch result
		{
			case .completed:
				AutumnLog.debug("Waiting for [\(element)] to become [\(clause)] within \(timeout) seconds ... Result: completed")
				return true
			case .invertedFulfillment:
				AutumnLog.debug("Waiting for [\(element)] to become [\(clause)] within \(timeout) seconds ... Result: invertedFulfillment")
				return true
			case .timedOut:
				AutumnLog.debug("Waiting for [\(element)] to become [\(clause)] within \(timeout) seconds ... Result: timedOut")
			case .incorrectOrder:
				AutumnLog.debug("Waiting for [\(element)] to become [\(clause)] within \(timeout) seconds ... Result: incorrectOrder")
			case .interrupted:
				AutumnLog.debug("Waiting for [\(element)] to become [\(clause)] within \(timeout) seconds ... Result: interrupted")
		}
		
		return false
	}
	
	
	/// Alternative wait method that uses an interval.
	///
	/// - Parameters:
	/// 	- completeBlock: Block that is executed after the evalblock evaluates to true or the timeout is reached.
	/// 	- timeout: Max. time in seconds to wait before giving up.
	/// 	- evalblock: Block that needs to return true for the wait to result in a success.
	///
	public class func waitForWithInterval(completeBlock:((_ success:Bool) -> Void)? = nil, timeout:Int = 30, evalblock:@escaping (() -> Bool))
	{
		var count = 0
		let interval = Interval()
		interval.start()
		{
			count += 1
			sleep(1)
			if evalblock() != true && count < timeout { return }
			interval.stop()
			let success = count <= timeout
			completeBlock?(success)
		}
		interval.fire()
	}
	
	
	/// Ass-simple brute force wait method for when nothing else works.
	///
	public class func waitUntil(timeout:Int = 30, evalblock:@escaping (() -> Bool))
	{
		var count = 0
		repeat
		{
			if count >= timeout || evalblock() == true
			{
				break
			}
			else
			{
				sleep(1)
			}
			count += 1
		}
		while true
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - UI Interaction
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Sends a tap event to a hittable point computed for the element.
	 *
	 * @param element
	 */
	public class func tap(_ element:XCUIElement) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.tap()
			return true
		}
		return false
	}
	
	
	/**
	 * Sends a tap event to a hittable point computed for the element. Does not fail if the eleemnt isn't hittable or doesn't exist.
	 *
	 * @param element
	 */
	public class func tapOptional(_ element:XCUIElement) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.tap()
			return true
		}
		return false
	}
	
	
	/**
	 * Types a string into the element. The element or a descendant must have keyboard focus; otherwise an
	 * error is raised.
	 *
	 * This API discards any modifiers set in the current context by +performWithKeyModifiers:block: so that
	 * it strictly interprets the provided text. To input keys with modifier flags, use  -typeKey:modifierFlags:.
	 *
	 * @param element
	 * @param text
	 */
	public class func typeText(_ element:XCUIElement, text:String) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.typeText(text)
			return true
		}
		return false
	}
	
	
	/**
	 * Sends a swipe-up gesture.
	 * @param element
	 */
	public class func swipeUp(_ element:XCUIElement) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.swipeUp()
			return true
		}
		return false
	}
	
	
	/**
	 * Sends a swipe-down gesture.
	 * @param element
	 */
	public class func swipeDown(_ element:XCUIElement) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.swipeDown()
			return true
		}
		return false
	}
	
	
	/**
	 * Sends a swipe-left gesture.
	 * @param element
	 */
	public class func swipeLeft(_ element:XCUIElement) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.swipeLeft()
			return true
		}
		return false
	}
	
	/**
	 * Sends a swipe-right gesture.
	 * @param element
	 */
	public class func swipeRight(_ element:XCUIElement) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.swipeRight()
			return true
		}
		return false
	}
	
	
	public class func customSwipe(refElement:XCUIElement, startCoord:CGVector, endCoord:CGVector)
	{
		let swipeStartPoint = refElement.coordinate(withNormalizedOffset: startCoord)
		let swipeEndPoint = refElement.coordinate(withNormalizedOffset: endCoord)
		swipeStartPoint.press(forDuration: 0.1, thenDragTo: swipeEndPoint)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Assertion
	// ----------------------------------------------------------------------------------------------------
	
	public class func verifyExists(_ element:XCUIElement) -> Bool
	{
		let result = element.exists
		AutumnLog.debug("Verify exists [\(element)]: \(result)")
		return result
	}
	
	
	public class func verifyHittable(_ element:XCUIElement) -> Bool
	{
		let result = element.isHittable
		AutumnLog.debug("Verify hittable [\(element)]: \(result)")
		return result
	}
}
