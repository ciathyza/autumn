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
 * Represents a test scenario that defines test steps.
 */
public class AutumnScenario
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
	
	public var uninstallBefore = true
	public var resetBefore = true
	public var resetAfter = false
	public var terminateAfter = true
	
	public internal(set) var id = ""
	public internal(set) var name = ""
	public internal(set) var descr = ""
	public internal(set) var link = ""
	public internal(set) var tags = [String]()
	
	public private(set) var feature:AutumnFeature
	public private(set) var app:XCUIApplication
	public private(set) var runner:AutumnTestRunner
	
	internal var status = AutumnTestStatus.Pending
	internal private(set) var steps = [AutumnTestStep]()
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Derrived Properties
	// ----------------------------------------------------------------------------------------------------
	
	internal var tagsString:String
	{
		var s = ""
		for (i, value) in tags.enumerated()
		{
			s += "\(value)"
			if i < tags.count - 1 { s += ", " }
		}
		return s.trimmed
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Query Convenience API
	// ----------------------------------------------------------------------------------------------------
	
	public var isAppRunningInForeground:Bool { return AutumnTestRunner.app.state == .runningForeground }
	public var isAppRunningInBackground:Bool { return AutumnTestRunner.app.state == .runningBackground }
	public var isAppSuspendedInBackground:Bool { return AutumnTestRunner.app.state == .runningBackgroundSuspended }
	public var isAppInstalled:Bool { return Springboard.isAppInstalled }
	public var isAppKilled:Bool { return AutumnTestRunner.app.state != .runningForeground && AutumnTestRunner.app.state != .runningBackground && AutumnTestRunner.app.state != .runningBackgroundSuspended }
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Initializers
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Initializes a new scenario.as
	 */
	required public init(_ feature:AutumnFeature)
	{
		self.feature = feature
		app = feature.app
		runner = feature.runner
		
		setup()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Abstract Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Sets up the scenario. Implement this method in the sub class and set all the properties here.
	 * This method is called automatically.
	 */
	open func setup()
	{
	}
	
	
	/**
	 * Establishes the test scenario preconditions. Use 'given' calls here!
	 * This method is called automatically.
	 */
	open func establish()
	{
	}
	
	
	/**
	 * Executes the actual test scenario steps. Use 'when' and 'then' calls here!
	 * This method is called automatically.
	 */
	open func execute()
	{
	}
}
