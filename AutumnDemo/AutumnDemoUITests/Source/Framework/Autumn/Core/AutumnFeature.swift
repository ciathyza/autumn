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
	public private(set) var autumn:AutumnSetup
	public internal(set) var name = ""
	public internal(set) var tags = [String]()
	
	private static var _scenarioQueue:[Metatype<AutumnScenario>] = []
	private var _currentScenarioIndex = 0
	private var _currentScenario:AutumnScenario?
	private var _interval = Interval()
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Derrived Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var tagsString:String
	{
		var s = ""
		for t in tags { s += "\(t) " }
		return s.trimmed
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Initializers
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Initializes the feature.
	 */
	required public init(_ autumn:AutumnSetup)
	{
		self.app = AutumnSetup.app
		self.autumn = autumn
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
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Public Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Registers a test scenario for the feature.
	 */
	public func registerScenario(_ scenarioClass:AutumnScenario.Type)
	{
	}
	
	/**
	 * Returns the ID of the specified scenario class. The class must include the Testrail ID.
	 * It can be written in one of two ways, e.g.: ScenarioClassName_C110134 or C110134.
	 */
	public func getScenarioID(_ scenarioClass:AutumnScenario.Type) -> String
	{
		return ""
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Internal Methods
	// ----------------------------------------------------------------------------------------------------

	/**
	 * Starts testing the feature.
	 */
	func start()
	{
		startNextScenario()
	}
	
	
	/**
	 * Executes the next scenario in the queue.
	 */
	func startNextScenario()
	{
	}
	
	
	/**
	 * Executes a specific scenario.
	 */
	func startScenario(_ scenarioClass:AutumnScenario.Type)
	{
	}
	
	
	/**
	 * Starts a single, specific scenario. Used for classic test execution mode only!
	 */
	func startSingleScenario(_ scenarioClass:AutumnScenario.Type)
	{
	}
	
	
	/**
	 * Ends testing the feature.
	 */
	func end()
	{
	}
	
	
	/**
	 * Returns next scenario class or nil.
	 */
	func getNextScenarioClass() -> AutumnScenario.Type?
	{
		return nil
	}
	
	
	/**
	 * Waits for the currently executed scenario to be finished.
	 */
	func waitForScenarioComplete(_ scenario:AutumnScenario)
	{
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Handlers
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Invoked when a scenario has completed test execution.
	 */
	func onScenarioComplete(_ success:Bool)
	{
	}
}


/**
 * Empty default feature class used for non-optional instantiation.
 */
class AutumnEmptyFeature : AutumnFeature
{
	override func setup()
	{
	}
	
	override func registerScenarios()
	{
	}
	
	override func preLaunch()
	{
	}
	
	override func resetApp() -> Bool
	{
		return false
	}
	
	override func gotoView(_ viewID:AutumnViewProxy.Type, _ ready:Bool) -> Bool
	{
		return false
	}
}
