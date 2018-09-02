/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Ciathyza.
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
	 * Allows to add other results to this result. This way you can use other step classes inside this step class,
	 * e.g. result.add(Wait(5).execute())
	 */
	public func add(_ result:AutumnTestStepResult)
	{
		for i in result.instructions
		{
			instructions.append((i.instruction, i.result))
		}
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
