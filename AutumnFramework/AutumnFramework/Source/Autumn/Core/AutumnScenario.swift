//
// AutumnScenario.swift
// AutumnFramework
//
// Created by Sascha, Balkau | FINAD on 2018/02/27.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation
import XCTest


/**
 * Represents a test scenario that defines test steps.
 */
class AutumnScenario
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Static
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Convenience static computed property to get the wrapped metatype value.
	 */
	public static var metatype:Metatype<AutumnScenario>
	{
		return Metatype(self)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var app:XCUIApplication
	public var setup:AutumnTestSetup
	public var viewName:String
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Initializers
	// ----------------------------------------------------------------------------------------------------
	
	required public init(_ setup:AutumnTestSetup, _ viewName:String = "")
	{
		self.app = AutumnTestSetup.app
		self.setup = setup
		self.viewName = viewName
	}
}
