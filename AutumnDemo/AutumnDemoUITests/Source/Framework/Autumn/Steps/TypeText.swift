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
 * A test step that types text into a given UI input field.
 */
public class TypeText: AutumnTestStepAdv
{
	internal var _text:String
	
	
	public init(_ aci:(name:String, id:String), _ text:String, _ elementType:XCUIElement.ElementType = .textField)
	{
		_text = text
		super.init(aci, elementType)
	}
	
	
	public override func setup()
	{
		name = "the user enters '\(_text)' into \(elementName)"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(id)]", AutumnUI.tap(element))
		result.add("Tap [\(id) clear button] if available", AutumnUI.tapOptional(element?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		result.add("Enter '\(_text)' into [\(id)]", AutumnUI.typeText(element, text: _text))
		return result
	}
}
