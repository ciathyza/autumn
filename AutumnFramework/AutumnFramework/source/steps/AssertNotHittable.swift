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
 * A test step used to assert the specified element not being hittable.
 */
public class AssertNotHittable : AutumnUITestStep
{
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
