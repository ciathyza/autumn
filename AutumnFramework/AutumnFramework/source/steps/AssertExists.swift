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
 * A test step used to assert the existance of the specified element.
 */
public class AssertExists : AutumnTestStepAdv
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
		name = "\(elementName) exists"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Assert [\(id)] exists", AutumnUI.assertExists(element))
		return result
	}
}
