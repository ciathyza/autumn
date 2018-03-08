/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import Foundation


/**
 * A test step that let's the app wait for X seconds.
 */
public class WhenWait : AutumnTestStep
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	private var _seconds:UInt = 0;

	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	public init(_ seconds:UInt)
	{
		_seconds = seconds
		super.init()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public override func setup()
	{
		type = .When
		name = "the user waits for \(_seconds) seconds"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Wait \(_seconds) Seconds", AutumnUI.wait(_seconds))
		return result
	}
}
