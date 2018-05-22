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
 * A test step that taps the specified UI element multiple times.
 */
public class TapMulti : AutumnUITestStep
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public override func setup()
	{
		if name.isEmpty { name = "\(elementName) is tapped several times" }
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		let n = Int(arc4random_uniform(8) + 2)
		result.add("Tap [\(id)] \(n) times", AutumnUI.tapMulti(element, n))
		return result
	}
}
