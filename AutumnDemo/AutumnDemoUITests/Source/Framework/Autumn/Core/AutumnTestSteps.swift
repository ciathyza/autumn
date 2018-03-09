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
public class WaitForExists : AutumnTestStep
{
	
	private var _element:XCUIElement!
	private var _timeout:UInt = 0
	
	public init(_ element:XCUIElement, _ timeout:UInt = 0)
	{
		_element = element
		_timeout = timeout > 0 ? timeout : AutumnTestRunner.instance.config.viewPresentTimeout
		super.init()
	}
	
	public override func setup()
	{
		name = "\(_element.identifier) exists within \(_timeout) seconds"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Wait for [\(_element.identifier)] to exist within \(_timeout) seconds", AutumnUI.waitForExists(_element, timeout: _timeout))
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that waits for a given UI element to exist.
 */
public class Tap : AutumnTestStep
{
	
	private var _element:XCUIElement!
	
	public init(_ element:XCUIElement)
	{
		_element = element
		super.init()
	}
	
	public override func setup()
	{
		name = "\(_element.identifier) is tapped"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(_element.identifier)]", AutumnUI.tap(_element))
		return result
	}
}
