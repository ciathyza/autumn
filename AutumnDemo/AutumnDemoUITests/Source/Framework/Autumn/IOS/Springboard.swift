/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import UIKit
import XCTest


/**
 * Provides additional, automated functionality for the iOS Springboard.
 */
class Springboard
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	static let springboard:XCUIApplication? = XCUIApplication(bundleIdentifier: "com.apple.springboard")
	static let settings:XCUIApplication? = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
	
	static var isAppInstalled:Bool
	{
		return getAppIcon() != nil
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	class func killApp(app:XCUIApplication) -> Bool
	{
		if (UIDevice.isSimulator)
		{
			AutumnLog.warning("Task kill is currently not supported when running on simulator.")
			return false
		}
		
		app.terminate()
		if let springboard = springboard
		{
			springboard.activate()
			XCUIDevice.shared.press(.home)
			XCUIDevice.shared.press(.home)
			Thread.sleep(forTimeInterval: 1.0)
			let appTask = app.otherElements[AutumnTestRunner.instance.config.appID]
			if appTask.isHittable
			{
				appTask.swipeUp()
				XCUIDevice.shared.press(.home)
				return true
			}
			else
			{
				AutumnLog.error("App task is not hittable!")
				return false
			}
		}
		return false
	}
	
	
	/// Uninstalls the app via springboard.
	///
	class func uninstallApp(app:XCUIApplication) -> Bool
	{
		app.terminate()
		
		if let springboard = springboard
		{
			springboard.activate()
			
			/* Force delete the app from the springboard. */
			if let icon = getAppIcon()
			{
				let iconFrame = icon.frame
				let springboardFrame = springboard.frame
				icon.press(forDuration: 1.3)
				
				/* Tap the little "X" button at approximately where it is. The X is not exposed directly. */
				springboard.coordinate(withNormalizedOffset: CGVector(dx: (iconFrame.minX + 3) / springboardFrame.maxX, dy: (iconFrame.minY + 3) / springboardFrame.maxY)).tap()
				springboard.alerts.buttons["Delete"].tap()
				
				/* Press home once to make the icons stop wiggling. */
				XCUIDevice.shared.press(.home)
				/* Press home again to go to the first page of the springboard. */
				XCUIDevice.shared.press(.home)
				/* Wait some time for the animation to end. */
				Thread.sleep(forTimeInterval: 0.5)
				
				if let settings = settings
				{
					let settingsIcon = springboard.icons["Settings"]
					
					/* Still not on back on the first page? */
					if !settingsIcon.isHittable
					{
						XCUIDevice.shared.press(.home)
						Thread.sleep(forTimeInterval: 0.5)
					}
					
					if settingsIcon.isHittable
					{
						settingsIcon.tap()
						Thread.sleep(forTimeInterval: 0.25)
						settings.tables.staticTexts["General"].tap()
						Thread.sleep(forTimeInterval: 0.25)
						settings.tables.staticTexts["Reset"].tap()
						Thread.sleep(forTimeInterval: 0.25)
						settings.tables.staticTexts["Reset Location & Privacy"].tap()
						Thread.sleep(forTimeInterval: 0.25)
						settings.buttons["Reset Warnings"].tap()
						settings.terminate()
					}
					else
					{
						AutumnLog.error("iOS Settings app is not hittable!")
						return false
					}
				}
				else
				{
					AutumnLog.error("iOS Settings app not found!")
					return false
				}
			}
			else
			{
				AutumnLog.notice("App icon for \(AutumnTestRunner.instance.config.appName) not found!")
			}
		}
		else
		{
			AutumnLog.error("Springboard not found!")
			return false
		}
		
		return true
	}
	
	
	class func getAppIcon() -> XCUIElement?
	{
		if let icon = springboard?.icons[AutumnTestRunner.instance.config.appName]
		{
			if icon.exists && icon.isHittable { return icon }
		}
		XCUIDevice.shared.press(.home)
		Thread.sleep(forTimeInterval: 0.5)
		if let icon = springboard?.icons[AutumnTestRunner.instance.config.appName]
		{
			if icon.exists && icon.isHittable { return icon }
		}
		springboard?.swipeLeft()
		Thread.sleep(forTimeInterval: 0.5)
		if let icon = springboard?.icons[AutumnTestRunner.instance.config.appName]
		{
			if icon.exists && icon.isHittable { return icon }
		}
		springboard?.swipeLeft()
		Thread.sleep(forTimeInterval: 0.5)
		if let icon = springboard?.icons[AutumnTestRunner.instance.config.appName]
		{
			if icon.exists && icon.isHittable { return icon }
		}
		
		return nil
	}
}
