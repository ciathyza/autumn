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
 * A test step used to assert the specified element being hittable.
 */
public class AssertHittable : AutumnUITestStep
{
	public override func setup()
	{
		name = "\(elementName) is hittable"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Assert [\(id)] is hittable", AutumnUI.assertHittable(element))
		return result
	}
}
