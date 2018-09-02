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
 * A test step that taps the specified UI element if it can be tapped. Otherwise ignores it and doesn't
 * cause a failure.
 */
public class TapOptional : AutumnUITestStep
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public override func setup()
	{
		if name.isEmpty { name = "\(elementName) is tapped if hittable" }
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap Optional [\(id)]", AutumnUI.tapOptional(element))
		return result
	}
}
