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


// ------------------------------------------------------------------------------------------------

/**
 * A test step that launches the app.
 */
public class LaunchApp : AutumnTestStep
{
	public override func setup()
	{
		name = "the user has launched the app"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Launch App", AutumnUI.launchApp())
		result.add("Is App Running In Foreground", scenario.isAppRunningInForeground)
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that let's the app wait for X seconds.
 */
public class Wait : AutumnTestStep
{
	private var _seconds:UInt = 0
	
	public init(_ seconds:UInt)
	{
		_seconds = seconds
		super.init()
	}
	
	public override func setup()
	{
		name = "the user waits for \(_seconds) seconds"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Wait \(_seconds) Seconds", AutumnUI.wait(_seconds))
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that waits for a given UI element to exist.
 */
public class WaitForExists : AutumnTestStepAdv
{
	private var _timeout:UInt = 0
	
	public init(_ aci:(name:String, id:String), _ elementType:XCUIElement.ElementType = .any, _ timeout:UInt = 0)
	{
		_timeout = timeout > 0 ? timeout : AutumnTestRunner.instance.config.viewPresentTimeout
		super.init(aci, elementType)
	}
	
	public override func setup()
	{
		name = "\(elementName) exists within \(_timeout) seconds"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Wait for [\(id)] to exist within \(_timeout) seconds", AutumnUI.waitForExists(element, timeout: _timeout))
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that waits for a given UI element to exist.
 */
public class Tap : AutumnTestStepAdv
{
	public override init(_ aci:(name:String, id:String), _ elementType:XCUIElement.ElementType = .any)
	{
		super.init(aci, elementType)
	}
	
	public override func setup()
	{
		name = "\(elementName) is tapped"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(id)]", AutumnUI.tap(element))
		return result
	}
}
