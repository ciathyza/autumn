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
 * Represents a test step that is executed in a test scenario.
 */
public class AutumnTestStep : Hashable, Equatable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var type = AutumnStepType.None
	public var status = AutumnTestStatus.Normal
	public var name = ""
	
	open private(set) var result = AutumnTestStepResult()
	internal var phase = AutumnScenarioPhase.None
	internal var scenario:AutumnScenario!
	
	public var hashValue:Int
	{
		return name.hashValue
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	public init()
	{
		setup()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public static func ==(lhs:AutumnTestStep, rhs:AutumnTestStep) -> Bool
	{
		return lhs.hashValue == rhs.hashValue
	}
	
	
	/**
	 * Abstract method! Override and set type, status, and name here!
	 */
	open func setup()
	{
	}
	
	
	/**
	 * Abstract method! Override and execute test instructions here and return the result!
	 */
	open func execute() -> AutumnTestStepResult
	{
		return AutumnTestStepResult()
	}
}
