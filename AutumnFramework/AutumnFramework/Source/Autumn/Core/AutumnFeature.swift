//
// AutumnFeature.swift
// AutumnFramework
//
// Created by Sascha, Balkau | FINAD on 2018/02/27.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation
import XCTest


/**
 * Represents a test feature that holds several test scenarios.
 */
public class AutumnFeature
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Static
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Convenience static computed property to get the wrapped metatype value.
	 */
	public static var metatype:Metatype<AutumnFeature>
	{
		return Metatype(self)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public private(set) var app:XCUIApplication
	public private(set) var autumn:AutumnTestSetup
	public private(set) var viewName:String
	public internal(set) var featureName = ""
	public internal(set) var tags = [String]()
	
	var tagsString:String
	{
		var s = ""
		for t in tags { s += "\(t) " }
		return s.trimmed
	}
	
	private static var _scenarioQueue:[Metatype<AutumnScenario>] = []
	private var _currentScenarioIndex = 0
	private var _currentScenario:AutumnScenario?
	private var _interval = Interval()
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Initializers
	// ----------------------------------------------------------------------------------------------------
	
	required public init(_ autumn:AutumnTestSetup, _ viewName:String = "")
	{
		self.app = AutumnTestSetup.app
		self.autumn = autumn
		self.viewName = viewName
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Abstract Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Used to specify the meta data for the feature.
	 */
	open func setup()
	{
		/* Abstract method! */
		preconditionFailure("This method must be overridden!")
	}
	
	
	/**
	 * Used to register scenarios for the feature.
	 */
	open func registerScenarios()
	{
		/* Abstract method! */
		preconditionFailure("This method must be overridden!")
	}
	
	
	/**
	 * Used to execute pre-launch steps for the feature.
	 */
	open func preLaunch()
	{
		/* Abstract method! */
		preconditionFailure("This method must be overridden!")
	}
	
	
	/**
	 * Resets the application state. As the reset logic depends on the application, this method needs to
	 * be implemented on project basis.
	 */
	open func resetApp() -> Bool
	{
		/* Abstract method! */
		preconditionFailure("This method must be overridden!")
	}
	
	
	/**
	 * Proceeds to a specific view. Must be implemented by subclass!
	 *
	 * @param ready If true, makes the view ready for user interaction.
	 * @return true if the app proceeded successfully to the specified view.
	 */
	open func gotoView(_ viewID:AutumnViewProxy.Type, _ ready:Bool = false) -> Bool
	{
		/* Abstract method! */
		preconditionFailure("This method must be overridden!")
	}
}
