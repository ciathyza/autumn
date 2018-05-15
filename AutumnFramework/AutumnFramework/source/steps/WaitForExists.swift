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
public class WaitForExists : AutumnTestStepAdv
{
	private var _timeout:UInt = 0
	
	
	public init(_ aci:(name:String, id:String), _ elementType:XCUIElement.ElementType = .any, _ timeout:UInt = 0)
	{
		_timeout = timeout > 0 ? timeout : AutumnTestRunner.instance.config.viewPresentTimeout
		super.init(aci, elementType)
	}
	
	
	public init(_ element:XCUIElement, _ elementType:XCUIElement.ElementType = .any, _ timeout:UInt = 0)
	{
		_timeout = timeout > 0 ? timeout : AutumnTestRunner.instance.config.viewPresentTimeout
		super.init(element, elementType)
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
