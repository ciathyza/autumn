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
	
	internal private(set) var instructions = [[String:Bool]]()
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Adds a new test instruction.
	 */
	public func add(_ instruction:String, _ success:Bool)
	{
		instructions.append([instruction: success])
	}
	
	
	/**
	 * Evaluates all instructions to have the test step succeeded or failed.
	 * Only returns true if all instructions have succeeded.
	 */
	public func evaluate() -> Bool
	{
		for dict in instructions
		{
			for (_, value) in dict
			{
				if value == false
				{
					return false
				}
			}
		}
		return true
	}
}
