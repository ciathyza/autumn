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
 * A test step that clears a given UI input field.
 */
public class ClearInputField: AutumnTestStepAdv
{
	public init(_ aci:(name:String, id:String))
	{
		super.init(aci, .textField)
	}
	
	
	public override func setup()
	{
		name = "the user clears \(elementName)"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(id)]", AutumnUI.tap(element))
		result.add("Tap [\(id) clear button] if available", AutumnUI.tapOptional(element?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		return result
	}
}
