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
 * A test step that taps the specified UI element.
 */
public class Tap : AutumnUITestStep
{
	public override init(_ aci:(name:String, id:String), _ elementType:XCUIElement.ElementType = .any)
	{
		super.init(aci, elementType)
	}
	
	
	public override init(_ element:XCUIElement, _ elementType:XCUIElement.ElementType = .any)
	{
		super.init(element, elementType)
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
