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
 * A test step used to assert a given element not being hittable.
 */
public class AssertNotHittable : AutumnTestStepAdv
{
	public override init(_ aci:(name:String, id:String), _ elementType:XCUIElement.ElementType = .any)
	{
		super.init(aci, elementType)
	}
	
	
	public override func setup()
	{
		name = "\(elementName) is not hittable"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Assert [\(id)] is not hittable", AutumnUI.assertNotHittable(element))
		return result
	}
}
