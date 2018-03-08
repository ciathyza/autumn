/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import Foundation


/**
 * A test step that launches the app.
 */
public class GivenLaunchApp : AutumnTestStep
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public override func setup()
	{
		type = .Given
		name = "the user has launched the app"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Launch App", AutumnUI.launchApp())
		result.add("Is App Running In Foreground", scenario.isAppRunningInForeground)
		return result
	}
}
