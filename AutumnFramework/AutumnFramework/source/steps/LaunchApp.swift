/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Ciathyza.
 */

import Foundation
import XCTest


/**
 * A test step that launches the app.
 */
public class LaunchApp : AutumnTestStep
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public override func setup()
	{
		if name.isEmpty { name = "the app is launched" }
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Launch App", AutumnUI.launchApp())
		result.add("Is App Running In Foreground", AutumnUI.isAppRunningInForeground)
		return result
	}
}
