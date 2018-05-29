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
	
	
	/**
	 * Resets iOS state for the application.
	 */
	class func resetState(app:XCUIApplication, _ uninstall:Bool = true, _ resetWarnings:Bool = true, _ clearBrowserData:Bool = true) -> Bool
	{
		app.terminate()
		
		if let springboard = springboard
		{
			springboard.activate()
			
			if uninstall
			{
				if let appIcon = getAppIcon()
				{
					let appIconFrame = appIcon.frame
					let springboardFrame = springboard.frame
					_ = AutumnUI.press(appIcon, 1.3)
					
					/* Tap the little "X" button at approximately where it is. The X is not exposed directly. */
					let vector = CGVector(dx: (appIconFrame.minX + 3) / springboardFrame.maxX, dy: (appIconFrame.minY + 3) / springboardFrame.maxY)
					_ = AutumnUI.tap(springboard.coordinate(withNormalizedOffset: vector))
					_ = AutumnUI.tap(springboard.alerts.buttons["Delete"])
					
					/* Press home once to make the icons stop wiggling. */
					AutumnUI.pressHomeButton()
					_ = AutumnUI.wait(1)
				}
				else
				{
					AutumnLog.notice("App icon for \(AutumnTestRunner.instance.config.appName) not found!")
				}
			}
			
			if resetWarnings || clearBrowserData
			{
				/* Press home again to go to the first page of the springboard. */
				AutumnUI.pressHomeButton()
				
				if let settings = settings
				{
					let settingsIcon = springboard.icons["Settings"]
					
					/* Still not back on the first springboard page? */
					if !settingsIcon.isHittable
					{
						AutumnUI.pressHomeButton()
						_ = AutumnUI.waitForHittable(settingsIcon)
					}
					
					if settingsIcon.isHittable
					{
						/* Enter device settings. */
						_ = AutumnUI.tap(settingsIcon)
						
						if resetWarnings
						{
							let settingsGeneralFolder = settings.tables.staticTexts["General"]
							let settingsResetFolder = settings.tables.staticTexts["Reset"]
							let settingsResetLocationButton = settings.tables.staticTexts["Reset Location & Privacy"]
							let settingsResetWarningsButton = settings.buttons["Reset Warnings"]
							
							if AutumnUI.waitForHittableAndTap(settingsGeneralFolder) == AutumnUIActionResult.Success
							{
								if AutumnUI.waitForHittableAndTap(settingsResetFolder) == AutumnUIActionResult.Success
								{
									if AutumnUI.waitForHittableAndTap(settingsResetLocationButton) == AutumnUIActionResult.Success
									{
										if AutumnUI.waitForHittableAndTap(settingsResetWarningsButton) == AutumnUIActionResult.Success
										{
											AutumnLog.debug("Reset locations and privacy warnings.")
										}
									}
								}
							}
							
							if clearBrowserData
							{
								/* Go back to Settings main page. */
								let settingsResetBackButton = settings.navigationBars["Reset"].buttons["General"]
								let settingsGeneralBackButton = settings.navigationBars["General"].buttons["Settings"]
								_ = AutumnUI.tap(settingsResetBackButton)
								_ = AutumnUI.waitForHittableAndTap(settingsGeneralBackButton)
								_ = AutumnUI.waitForHittable(settingsGeneralFolder)
							}
						}
						
						if clearBrowserData
						{
							let settingsSafariFolder = settings.tables.staticTexts["Safari"]
							let settingsSafariTable = settings.tables.element(boundBy: 0)
							let settingsSafariClearHistoryButton = settings.tables.staticTexts["Clear History and Website Data"]
							let settingsSafariClearHistorySheetButton = settings.sheets["Clearing will remove history, cookies, and other browsing data."].buttons["Clear History and Data"]
							
							_ = AutumnUI.waitForHittableAndTap(settingsSafariFolder)
							if AutumnUI.swipeUpUntilHittable(settingsSafariTable, settingsSafariClearHistoryButton) == AutumnUIActionResult.Success
							{
								if AutumnUI.tap(settingsSafariClearHistoryButton) == AutumnUIActionResult.Success
								{
									if AutumnUI.tap(settingsSafariClearHistorySheetButton) == AutumnUIActionResult.Success
									{
										AutumnLog.debug("Cleared browser data.")
									}
								}
							}
							
							_ = AutumnUI.wait(1)
							settings.terminate()
						}
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
		}
		else
		{
			AutumnLog.error("Springboard not found!")
			return false
		}
		
		return true
	}
	
	
	class func changeDeviceTime(app:XCUIApplication) -> Bool
	{
		app.terminate()
		
		if let springboard = springboard
		{
			springboard.activate()
			
			/* Press home again to go to the first page of the springboard. */
			AutumnUI.pressHomeButton()
			
			if let settings = settings
			{
				let settingsIcon = springboard.icons["Settings"]
				
				/* Still not back on the first springboard page? */
				if !settingsIcon.isHittable
				{
					AutumnUI.pressHomeButton()
					_ = AutumnUI.waitForHittable(settingsIcon)
				}
				
				if settingsIcon.isHittable
				{
					/* Enter device settings. */
					_ = AutumnUI.tap(settingsIcon)
					
					let settingsGeneralTable = settings.tables.element(boundBy: 0)
					let settingsGeneralFolder = settings.tables.staticTexts["General"]
					let settingsGeneralDateTimeButton = settings.tables.staticTexts["Date & Time"]
					let settingsGeneralDateTimeAutomaticSwitch = settings.tables.switches["Set Automatically"]
					let settingsGeneralDateTimePickerWheel = settings.tables.pickerWheels.element(boundBy: 0)
					
					if !settingsGeneralFolder.isHittable
					{
						AutumnUI.swipeUpUntilHittable(settingsGeneralTable, settingsGeneralFolder)
					}
					if settingsGeneralFolder.isHittable
					{
						_ = AutumnUI.waitForHittableAndTap(settingsGeneralFolder)
						if AutumnUI.swipeUpUntilHittable(settingsGeneralTable, settingsGeneralDateTimeButton) == AutumnUIActionResult.Success
						{
							if AutumnUI.tap(settingsGeneralDateTimeButton) == AutumnUIActionResult.Success
							{
								if AutumnUI.tap(settingsGeneralDateTimeAutomaticSwitch) == AutumnUIActionResult.Success
								{
									if AutumnUI.tap(settingsGeneralDateTimePickerWheel) == AutumnUIActionResult.Success
									{
										// TODO
									}
								}
							}
						}
						else
						{
							AutumnLog.error("iOS Settings Date & Time button is not hittable!")
							return false
						}
					}
					else
					{
						AutumnLog.error("iOS Settings General category button is not hittable!")
						return false
					}
					
					
					_ = AutumnUI.wait(1)
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
