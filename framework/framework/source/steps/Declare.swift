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
 * A simple test step that can be used to create non-evaluating Then steps.
 */
public class Declare: AutumnTestStep
{
	private var _message:String
	
	
	public init(_ message:String)
	{
		_message = message
		super.init()
	}
	
	
	public override func setup()
	{
		name = _message
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Declare \(_message)", .Success)
		return result
	}
}
