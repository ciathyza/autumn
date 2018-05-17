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
 * A test step that can be used to output a message with a specific result.
 * This step can be used in situations where no test logic is required and the result is certain.
 */
public class Message : AutumnTestStep
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	private var _message:String
	private var _uiResult:AutumnUIActionResult
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	public init(_ message:String, _ result:AutumnUIActionResult = .Success)
	{
		_message = message
		_uiResult = result
		super.init()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public override func setup()
	{
		if name.isEmpty { name = _message }
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("\(_message)", _uiResult)
		return result
	}
}
