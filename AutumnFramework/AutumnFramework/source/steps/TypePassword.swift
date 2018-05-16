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
 * A test step that types a password into the specified UI input field.
 * The input field mut be a secure text field for this to work.
 *
 * If the input field still contains any text it will be cleared before entering the new text.
 */
public class TypePassword : TypeText
{
	public override init(_ aci:(name:String, id:String), _ text:String, _ elementType:XCUIElement.ElementType = .secureTextField)
	{
		super.init(aci, text, elementType)
	}
	
	
	public override init(_ element:XCUIElement, _ text:String, _ elementType:XCUIElement.ElementType = .secureTextField)
	{
		super.init(element, text, elementType)
	}
	
	
	public override func setup()
	{
		if name.isEmpty { name = "'\(_text.obscured)' is entered into \(elementName)" }
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(id)]", AutumnUI.tap(element))
		result.add("Tap [\(id) clear button] if available", AutumnUI.tapOptional(element?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		result.add("Enter '\(_text.obscured)' into [\(id)]", AutumnUI.typeText(element, text: _text))
		return result
	}
}
