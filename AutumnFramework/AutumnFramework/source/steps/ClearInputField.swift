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
 * A test step that clears the specified text input field.
 */
public class ClearInputField : AutumnTestStepAdv
{
	public init(_ aci:(name:String, id:String))
	{
		super.init(aci, .textField)
	}
	
	
	public init(_ element:XCUIElement)
	{
		super.init(element, .textField)
	}
	
	
	public override func setup()
	{
		name = "\(elementName) is cleared"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(id)]", AutumnUI.tap(element))
		result.add("Tap [\(id) clear button] if available", AutumnUI.tapOptional(element?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		return result
	}
}
