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
 * Used to keep track of test step instructions and their results.
 */
public class AutumnTestStepResult
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Sequencial list of step instruction strings and their result.
	 */
	internal private(set) var instructions = [(instruction:String, result:AutumnUIActionResult)]()
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Adds a new test instruction.
	 */
	public func add(_ instruction:String, _ actionResult:AutumnUIActionResult)
	{
		instructions.append((instruction, actionResult))
	}
	
	
	/**
	 * Evaluates all instructions to have the test step succeeded or failed.
	 * Only returns true if all instructions have succeeded.
	 */
	public func evaluate() -> Bool
	{
		for (_, result) in instructions
		{
			if result != .Success { return false }
		}
		return true
	}
}
