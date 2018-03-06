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
	
	/**
	 * Launches the app to running in foreground state.
	 */
	public class func launchApp(_ app:XCUIApplication? = nil) -> Bool
	{
		if let app = app
		{
			app.launchArguments = ["--uitesting", "-StartFromCleanState", "YES"]
			app.launch()
			return app.state == .runningForeground
		}
		AutumnTestRunner.app.launchArguments = ["--uitesting", "-StartFromCleanState", "YES"]
		AutumnTestRunner.app.launch()
		return AutumnTestRunner.app.state == .runningForeground
	}
	
	
	/**
	 * Launches the app to running in foreground state.
	 */
	public class func activateApp(_ app:XCUIApplication? = nil) -> Bool
	{
		if let app = app
		{
			app.activate()
			return app.state == .runningForeground
		}
		AutumnTestRunner.app.activate()
		return AutumnTestRunner.app.state == .runningForeground
	}
	
	
	/**
	 * Terminates the app.
	 */
	public class func terminateApp(_ app:XCUIApplication? = nil) -> Bool
	{
		if let app = app
		{
			app.terminate()
			return app.state == .notRunning
		}
		AutumnTestRunner.app.terminate()
		return AutumnTestRunner.app.state == .notRunning
	}
	
	
	/**
	 * Task-kills the app.
	 */
	public class func killApp(_ app:XCUIApplication? = nil) -> Bool
	{
		if let app = app
		{
			return Springboard.killApp(app: app)
		}
		return Springboard.killApp(app: AutumnTestRunner.app)
	}
	
	
	/**
	 * Uninstalls the app.
	 */
	public class func uninstallApp(_ app:XCUIApplication? = nil) -> Bool
	{
		if let app = app
		{
			return Springboard.uninstallApp(app: app)
		}
		return Springboard.uninstallApp(app: AutumnTestRunner.app)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Wait
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Same as wait() method but without logging.
	 *
	 * @param interval The time to wait in seconds.
	 */
	public class func sleep(_ interval:UInt)
	{
		Darwin.sleep(UInt32(interval))
	}
	
	
	/**
	 * Waits for x seconds.
	 *
	 * @param interval The time to wait in seconds.
	 */
	public class func wait(_ interval:UInt)
	{
		sleep(interval)
	}
	
	
	/**
	 * Wait for an element to exist and be hittable (visible and onscreen).
	 *
	 * @param element Element to wait for.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was hittable within time limit, otherwise false.
	 */
	public class func waitForHittable(_ element:XCUIElement, timeout:UInt = 0) -> Bool
	{
		let clause = "hittable == true"
		let timeout = timeout == 0 ? AutumnTestRunner.instance.config.viewPresentTimeout : timeout
		let success = AutumnUI.waitFor(element, clause: clause, timeout: timeout)
		return success
	}
	
	
	/**
	 * Wait until an element is no longer hittable (might still exist, but is either not visible
	 * or not onscreen).
	 *
	 * @param element Element to wait for.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was hittable within time limit, otherwise false.
	 */
	public class func waitForNotHittable(_ element:XCUIElement, timeout:UInt = 0) -> Bool
	{
		let clause = "hittable == false"
		let timeout = timeout == 0 ? AutumnTestRunner.instance.config.viewPresentTimeout : timeout
		let success = AutumnUI.waitFor(element, clause: clause, timeout: timeout)
		return success
	}
	
	
	/**
	 * Wait for an element to exist (does not need to be visible or onscreen).
	 *
	 * @param element Element to wait for.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was hittable within time limit, otherwise false.
	 */
	public class func waitForExists(_ element:XCUIElement, timeout:UInt = 0) -> Bool
	{
		let clause = "exists == true"
		let timeout = timeout == 0 ? AutumnTestRunner.instance.config.viewPresentTimeout : timeout
		let success = AutumnUI.waitFor(element, clause: clause, timeout: timeout)
		return success
	}
	
	
	/**
	 * Wait for an element to not exist anymore.
	 *
	 * @param element Element to wait for.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was not found within time limit, otherwise false.
	 */
	public class func waitForNotExists(_ element:XCUIElement, timeout:UInt = 0) -> Bool
	{
		let clause = "exists == false"
		let timeout = timeout == 0 ? AutumnTestRunner.instance.config.viewPresentTimeout : timeout
		let success = AutumnUI.waitFor(element, clause: clause, timeout: timeout)
		return success
	}
	
	
	/**
	 * Wait for a property of an element to become true.
	 *
	 * @param element Element to wait for.
	 * @param property The element's property.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was hittable within time limit, otherwise false.
	 */
	public class func waitForIsTrue(_ object:NSObject, _ property:String, timeout:UInt = 0) -> Bool
	{
		let clause = "\(property) == true"
		let timeout = timeout == 0 ? AutumnTestRunner.instance.config.networkLoginTimeout : timeout
		let success = AutumnUI.waitFor(object, clause: clause, timeout: timeout)
		return success
	}
	
	
	/**
	 * Waits for an element with a specified conditional clause.
	 */
	public class func waitFor(_ element:Any, clause:String, timeout:UInt = 0) -> Bool
	{
		let timeout = timeout == 0 ? AutumnTestRunner.instance.config.viewPresentTimeout : timeout
		let predicate = NSPredicate(format: clause)
		let expectation = AutumnTestRunner.instance.expectation(for: predicate, evaluatedWith: element)
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
	
	
	/**
	 * Alternative wait method that uses an interval.
	 *
	 * @param completeBlock Block that is executed after the evalblock evaluates to true or the
	 *                      timeout is reached.
	 * @param timeout Max. time in seconds to wait before giving up.
	 * @param evalblock Block that needs to return true for the wait to result in a success.
	 */
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
	
	
	/**
	 * Ass-simple brute force wait method for when nothing else works.
	 *
	 * @param timeout Max. time in seconds to wait before giving up.
	 * @param evalblock Block that needs to return true for the wait to result in a success.
	 */
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
	
	
	/**
	 * Used to decelerate test execution if slow mode is active. Can be used for debugging the
	 * framework during development.
	 */
	public class func decelerate()
	{
		if (AutumnTestRunner.instance.config.slowSeconds > 0) { AutumnUI.wait(AutumnTestRunner.instance.config.slowSeconds) }
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
	
	
	/**
	 * As of yet unsupported!
	 */
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
		return result
	}
	
	
	public class func verifyHittable(_ element:XCUIElement) -> Bool
	{
		let result = element.isHittable
		return result
	}
}
