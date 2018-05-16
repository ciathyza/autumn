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
 * A test step used to assert the non-existance of the specified element.
 */
public class AssertNotExists : AutumnUITestStep
{
	public override func setup()
	{
		if name.isEmpty { name = "\(elementName) doesn't exist" }
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Assert [\(id)] not exists", AutumnUI.assertNotExists(element))
		return result
	}
}
