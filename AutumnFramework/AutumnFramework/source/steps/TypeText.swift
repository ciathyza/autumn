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
 * A test step that types text into the specified input field.
 *
 * If the input field still contains any text it will be cleared before entering the new text.
 */
public class TypeText : AutumnUITestStep
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	internal var _text:String
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	public init(_ aci:(name:String, id:String), _ text:String, _ elementType:XCUIElement.ElementType = .textField)
	{
		_text = text
		super.init(aci, elementType)
	}
	
	
	public init(_ dict:NSDictionary, _ text:String, _ elementType:XCUIElement.ElementType = .textField)
	{
		_text = text
		super.init(dict, elementType)
	}
	
	
	public init(_ str:String, _ text:String, _ elementType:XCUIElement.ElementType = .textField)
	{
		_text = text
		super.init(str, elementType)
	}
	
	
	public init(_ element:XCUIElement, _ text:String, _ elementType:XCUIElement.ElementType = .textField)
	{
		_text = text
		super.init(element, elementType)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public override func setup()
	{
		if name.isEmpty { name = "'\(_text)' is entered into \(elementName)" }
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(id)]", AutumnUI.tap(element))
		result.add("Tap [\(id) clear button] if available", AutumnUI.tapOptional(element?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		result.add("Enter '\(_text)' into [\(id)]", AutumnUI.typeText(element, text: _text))
		return result
	}
}
