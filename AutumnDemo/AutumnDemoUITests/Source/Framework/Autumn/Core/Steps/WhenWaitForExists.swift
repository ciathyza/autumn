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
 * A test step that waits for a given UI element to exist.
 */
public class WhenWaitForExists : AutumnTestStep
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	private var _element:XCUIElement!
	private var _timeout:UInt = 0
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	public init(_ element:XCUIElement, _ timeout:UInt = 0)
	{
		_element = element
		_timeout = timeout > 0 ? timeout : AutumnTestRunner.instance.config.viewPresentTimeout
		super.init()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public override func setup()
	{
		type = .When
		name = "\(_element.identifier) exists within \(_timeout) seconds"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Wait for [\(_element.identifier)] to exist within \(_timeout) seconds", AutumnUI.waitForExists(_element, timeout: _timeout))
		return result
	}
}
