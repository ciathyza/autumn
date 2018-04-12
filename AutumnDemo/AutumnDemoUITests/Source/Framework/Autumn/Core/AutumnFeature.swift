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
	
	public internal(set) var name = ""
	public internal(set) var descr = ""
	public internal(set) var tags = [String]()
	
	public private(set) var app:XCUIApplication
	public private(set) var runner:AutumnTestRunner
	internal private(set) var session:AutumnSession
	
	private static var _scenarioQueue:[Metatype<AutumnScenario>] = []
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
	required public init(_ runner:AutumnTestRunner)
	{
		self.app = AutumnTestRunner.app
		self.runner = runner
		self.session = runner.session
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
		if AutumnTestRunner.allScenarioClasses[scenarioClass.metatype] == nil
		{
			let scenario = scenarioClass.init(self)
			/* Add all feature tags to all its scenarios, too. */
			scenario.tags = scenario.tags + tags
			AutumnTestRunner.allScenarioClasses[scenarioClass.metatype] = scenarioClass
			let scenarioID = getScenarioID(scenarioClass)
			if !scenarioID.isEmpty
			{
				AutumnTestRunner.allScenarioIDs[scenarioClass.metatype] = scenarioID
				AutumnLog.debug("Registered test scenario with ID \(scenarioID).")
			}
			else
			{
				AutumnLog.warning("Scenario \"\(scenarioClass)\" has no ID!")
			}
		}
		
		AutumnFeature._scenarioQueue.append(scenarioClass.metatype)
	}
	
	
	/**
	 * Returns the ID of the specified scenario class. The class must include the Testrail ID.
	 * It can be written in one of two ways, e.g.: ScenarioClassName_C110134 or C110134.
	 */
	public func getScenarioID(_ scenarioClass:AutumnScenario.Type) -> String
	{
		let className = "\(scenarioClass)"
		let array = className.split("_")
		var result = ""
		
		/* Format: ScenarioClassName_C110134 */
		if array.count > 1
		{
			let s = array[array.count - 1]
			result = s
		}
		/* Format: C110134 */
		else if array.count == 1
		{
			let s = array[0]
			if (s.starts(with: "C"))
			{
				result = s.substring(1)
			}
		}
		if result.isEmpty
		{
			let scenario = scenarioClass.init(self)
			result = scenario.id
		}
		return result
	}
	
	
	/**
	 * Returns an array with all scenario metatypes that are used by this feature.
	 */
	public func getScenarioMetatypes() -> [Metatype<AutumnScenario>]
	{
		var metatypes = [Metatype<AutumnScenario>]()
		for c in AutumnFeature._scenarioQueue
		{
			metatypes.append(c)
		}
		return metatypes
	}
	
	
	/**
	 * Returns an array with all scenario classes that are used by this feature.
	 */
	public func getScenarioClasses() -> [AutumnScenario.Type]
	{
		let scenarioMetatypes = getScenarioMetatypes()
		var scenarioClasses = [AutumnScenario.Type]()
		for metatype in scenarioMetatypes
		{
			if let scenarioClass = AutumnTestRunner.allScenarioClasses[metatype]
			{
				scenarioClasses.append(scenarioClass)
			}
		}
		return scenarioClasses
	}
	
	
	/**
	 * Returns an array with all instantiated scenarios that are used by this feature.
	 */
	public func getScenarios() -> [AutumnScenario]
	{
		let scenarioMetatypes = getScenarioMetatypes()
		var scenarios = [AutumnScenario]()
		for metatype in scenarioMetatypes
		{
			if let scenarioClass = AutumnTestRunner.allScenarioClasses[metatype]
			{
				let scenario = scenarioClass.init(self)
				scenarios.append(scenario)
			}
		}
		return scenarios
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
		if let scenarioClass = getNextScenarioClass()
		{
			startScenario(scenarioClass)
		}
		else
		{
			AutumnLog.debug("All scenarios in feature completed.")
			runner.session.currentScenario = nil
			end()
		}
	}
	
	
	/**
	 * Executes a specific scenario.
	 */
	func startScenario(_ scenarioClass:AutumnScenario.Type)
	{
		runner.session.currentScenarioIndex += 1
		
		if let scenarioClass = AutumnTestRunner.allScenarioClasses[scenarioClass.metatype]
		{
			let scenario = scenarioClass.init(self)
			
			/* Use scenario ID that was retrieved from the class name. */
			if let scenarioID = AutumnTestRunner.allScenarioIDs[scenarioClass.metatype]
			{
				scenario.id = scenarioID
			}
			
			let scenarioLink = scenario.link.length > 0 ? scenario.link : runner.config.testrailFeatureBaseURL.length > 0 ? runner.config.testrailFeatureBaseURL + scenario.id : ""
			scenario.tags = scenario.tags + tags
			
			runner.session.currentScenario = scenario
			
			/* Is the scenario unsupported? */
			if scenario.tags.contains(AutumnTag.UNSUPPORTED)
			{
				//AutumnTelemetry.instance.record(type: .IgnoreScenario, args: self, scenario, scenarioLink)
				runner.session.stats.scenariosIgnored += 1
			}
			else
			{
				if scenario.resetBefore
				{
					AutumnUI.sleep(2)
					AutumnLog.debug("Resetting app state before scenario ...")
					_ = resetApp()
				}
				if scenario.uninstallBefore
				{
					AutumnUI.sleep(2)
					AutumnLog.debug("Uninstalling app before scenario ...")
					_ = AutumnUI.uninstallApp()
				}
				
				AutumnLog.delimiter()
				AutumnLog.debug("Starting scenario: \"[\(scenario.id)] \(scenario.name)\" (Link: \(scenarioLink), Tags: \(scenario.tagsString))")
				//AutumnTelemetry.instance.record(type: .BeginScenario, args: self, scenario, scenarioLink)
				AutumnLog.debug("Establishing scenario preconditions ...")
				scenario.status = .Started
				scenario.phase = .Precondition
				scenario.establish()
				AutumnLog.debug("Executing scenario steps ...")
				scenario.phase = .Execute
				scenario.execute()
				
				let results = scenario.getResults()
				session.evaluateScenarioResults(results)
				
				//scenario.status = scenario.steps.contains(where: { $0.successStatus == AutumnTestStatus.Failed }) ? .Failed : .Passed
				//AutumnTelemetry.instance.record(type: .EndScenario, args: self, scenario)
				
				if scenario.terminateAfter
				{
					_ = AutumnUI.terminateApp()
				}
				else
				{
					if scenario.resetAfter
					{
						AutumnLog.debug("Resetting app state after scenario [\(scenario.name)] ...")
						_ = resetApp()
					}
				}
				
				waitForScenarioComplete(scenario)
			}
		}
		else
		{
			AutumnLog.notice("No scenario was registered for class [\(scenarioClass.metatype)].")
		}
	}
	
	
	/**
	 * Starts a single, specific scenario. Used for classic test execution mode only!
	 */
	func startSingleScenario(_ scenarioClass:AutumnScenario.Type)
	{
		startScenario(scenarioClass)
	}
	
	
	/**
	 * Ends testing the feature.
	 */
	func end()
	{
		runner.session.startNextFeature()
	}
	
	
	/**
	 * Returns next scenario class or nil.
	 */
	func getNextScenarioClass() -> AutumnScenario.Type?
	{
		if (AutumnFeature._scenarioQueue.count > 0)
		{
			let metatype = AutumnFeature._scenarioQueue.removeFirst()
			return AutumnTestRunner.allScenarioClasses[metatype]
		}
		return nil
	}
	
	
	/**
	 * Waits for the currently executed scenario to be finished.
	 */
	func waitForScenarioComplete(_ scenario:AutumnScenario)
	{
		/* XCUITest won't wait for us to finish the async HTTP requests so we wait here before tearng down
		   to have a clean division between every scenario run. */
		AutumnUI.waitForWithInterval(completeBlock: onScenarioComplete, timeout: 20)
		{
			return true
			//return AutumnTelemetrySession.isTestRailSubmitComplete
		}
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Handlers
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Invoked when a scenario has completed test execution.
	 */
	func onScenarioComplete(_ success:Bool)
	{
		AutumnTestRunner.instance.tearDown()
		AutumnUI.sleep(1)
		startNextScenario()
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
