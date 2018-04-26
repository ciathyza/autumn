//
// AutumnTestStepResult.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/07.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


/**
 * Used to keep track of test step instructions and their results.
 */
open class AutumnTestStepResult
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
