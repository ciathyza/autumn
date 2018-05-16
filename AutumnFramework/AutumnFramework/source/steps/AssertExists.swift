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
public class AssertExists : AutumnUITestStep
{
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
