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
 * A test step that let's the app wait for x seconds.
 */
public class Wait : AutumnTestStep
{
	private var _seconds:UInt = 0
	
	
	public init(_ seconds:UInt)
	{
		_seconds = seconds
		super.init()
	}
	
	
	public override func setup()
	{
		if name.isEmpty { name = "the user waits for \(_seconds) seconds" }
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Wait \(_seconds) Seconds", AutumnUI.wait(_seconds))
		return result
	}
}
