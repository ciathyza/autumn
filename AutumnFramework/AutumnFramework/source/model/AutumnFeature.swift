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
open class AutumnFeature : AutumnHashable
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
	
	public var name = ""
	public var descr = ""
	public var tags = [String]()
	
	public private(set) var app:XCUIApplication
	public private(set) var runner:AutumnTestRunner
	internal private(set) var session:AutumnSession
	
	private var _scenarioQueue:[Metatype<AutumnScenario>] = []
	private var _interval = Interval()
	private var _scenarioTimer = ExecutionTimer()
	private var _scenarioRepeatCount = 0
	
	
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
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	public var hashValue:Int
	{
		return descr.hashValue
	}
	
	
	public static func ==(lhs:AutumnFeature, rhs:AutumnFeature) -> Bool
	{
		return lhs.name == rhs.name
			&& lhs.descr == rhs.descr
			&& lhs.tags.description == rhs.tags.description
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
		if runner.model.scenarioClasses[scenarioClass.metatype] == nil
		{
			let scenario = scenarioClass.init(self)
			
			/* Add all feature tags to all its scenarios, too. */
			scenario.tags = scenario.tags + tags
			
			runner.model.scenarioClasses[scenarioClass.metatype] = scenarioClass
			
			/* Get legitimate scenario ID. */
			if scenario.id.length > 0
			{
				if runner.model.scenarioIDs[scenarioClass.metatype] == nil
				{
					runner.model.scenarioIDs[scenarioClass.metatype] = scenario.id
					runner.session.stats.scenariosTotal += 1
					if scenario.status == .Pending { runner.session.stats.scenariosPending += 1 }
					else if scenario.status == .Unsupported { runner.session.stats.scenariosUnsupported += 1 }
					AutumnLog.debug("Registered test scenario with ID \(scenario.id).")
				}
			}
			else
			{
				AutumnLog.warning("Scenario \"\(scenarioClass)\" has no ID!")
			}
		}
		
		_scenarioQueue.append(scenarioClass.metatype)
	}
	
	
	/**
	 * Returns an array with all scenario metatypes that are used by this feature.
	 */
	public func getScenarioMetatypes() -> [Metatype<AutumnScenario>]
	{
		var metatypes = [Metatype<AutumnScenario>]()
		for c in _scenarioQueue
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
			if let scenarioClass = runner.model.scenarioClasses[metatype]
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
			if let scenarioClass = runner.model.scenarioClasses[metatype]
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
		_scenarioRepeatCount = 0
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
	
	
	func startScenario(_ scenarioClass:AutumnScenario.Type)
	{
		runner.session.currentScenarioIndex += 1
		
		if let scenarioClass = runner.model.scenarioClasses[scenarioClass.metatype]
		{
			let scenario = scenarioClass.init(self) as AutumnScenario
			/* Use scenario ID that was retrieved from the class name. */
			if let scenarioID = runner.model.scenarioIDs[scenarioClass.metatype]
			{
				scenario.id = scenarioID
			}
			startScenario(scenario)
		}
		else
		{
			AutumnLog.notice("No scenario was registered for class [\(scenarioClass.metatype)].")
		}
	}
	
	
	/**
	 * Executes a specific scenario.
	 */
	func startScenario(_ scenario:AutumnScenario)
	{
		var scenario = scenario
		let scenarioLink = scenario.link.length > 0 ? scenario.link : runner.config.testrailFeatureBaseURL.length > 0 ? runner.config.testrailFeatureBaseURL + "\(scenario.id)" : ""
		scenario.tags = scenario.tags + tags
		
		runner.session.currentScenario = scenario
		
		/* Is the scenario unsupported? */
		if scenario.status == .Pending || scenario.status == .Unsupported
		{
			AutumnLog.debug("Skipping \(scenario.status.rawValue) scenario: \"[\(scenario.id)] \(scenario.title)\" (Link: \(scenarioLink), Tags: \(scenario.tagsString))")
			runner.session.stats.scenariosIgnored += 1
			runner.submitTestResult(scenario)
			waitForScenarioComplete(scenario)
			onScenarioComplete(scenario, true)
		}
		else
		{
			runner.session.stats.scenariosStarted += 1
			
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
			AutumnLog.debug("Starting scenario: \"[\(scenario.id)] \(scenario.title)\" (Link: \(scenarioLink), Tags: \(scenario.tagsString))")
			
			/* Actual test case execution part. */
			AutumnLog.debug("Establishing scenario preconditions ...")
			scenario.status = .Started
			scenario.phase = .Precondition
			_scenarioTimer.start()
			scenario.establish()
			AutumnLog.debug("Executing scenario steps ...")
			scenario.phase = .Execute
			scenario.execute()
			_scenarioTimer.stop()
			runner.session.stats.scenariosExecuted += 1
			
			scenario.elapsed = _scenarioTimer.timeShort
			AutumnLog.debug("The scenario was executed in \(_scenarioTimer.timeLong).")
			
			let result = session.evaluateScenario(&scenario)
			if result.success
			{
				runner.session.stats.scenariosPassed += 1
			}
			else
			{
				runner.session.stats.scenariosFailed += 1
			}
			
			AutumnLog.debug(result.logText)
			runner.submitTestResult(scenario)
			waitForScenarioComplete(scenario)
			
			if scenario.terminateAfter
			{
				_ = AutumnUI.terminateApp()
			}
			else
			{
				if scenario.resetAfter
				{
					AutumnLog.debug("Resetting app state after scenario [\(scenario.title)] ...")
					_ = resetApp()
				}
			}
			
			onScenarioComplete(scenario, true)
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
		runner.session.endFeature()
	}
	
	
	/**
	 * Returns next scenario class or nil.
	 */
	func getNextScenarioClass() -> AutumnScenario.Type?
	{
		if (_scenarioQueue.count > 0)
		{
			let metatype = _scenarioQueue.removeFirst()
			return runner.model.scenarioClasses[metatype]
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
		AutumnUI.waitUntil()
		{
			return self.runner.isTestResultSubmitComplete()
		}
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Handlers
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Invoked when a scenario has completed test execution.
	 */
	func onScenarioComplete(_ scenario:AutumnScenario, _ success:Bool)
	{
		AutumnTestRunner.instance.tearDown()
		AutumnUI.sleep(1)
		
		if scenario.repeats > 0 && _scenarioRepeatCount < scenario.repeats
		{
			_scenarioRepeatCount += 1
			AutumnLog.debug("Repeating scenario \(scenario.id) (\(_scenarioRepeatCount) of \(scenario.repeats)) ...")
			scenario.reset()
			startScenario(scenario)
		}
		else
		{
			startNextScenario()
		}
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
