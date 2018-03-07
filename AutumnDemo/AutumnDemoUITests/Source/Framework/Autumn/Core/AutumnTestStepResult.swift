//
// AutumnTestStepResult.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/07.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


open class AutumnTestStepResult
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	private var details = [[String:Bool]]()
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public func add(_ instruction:String, _ success:Bool)
	{
		details.append([instruction: success])
	}
	
	
	public func evaluate() -> Bool
	{
		for dict in details
		{
			for (key, value) in dict
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
