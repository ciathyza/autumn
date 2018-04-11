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
	public internal(set) var priority = TestRailTestCasePriorityOption.Medium
	
	public private(set) var feature:AutumnFeature
	public private(set) var app:XCUIApplication
	public private(set) var runner:AutumnTestRunner
	
	internal var phase = AutumnScenarioPhase.None
	internal var status = AutumnTestStatus.Pending
	internal private(set) var steps = [AutumnTestStep]()
	internal private(set) var results = [[AutumnTestStep:AutumnTestStepResult]]()
	
	/* Used to store precondition (given) and execution (when/then) step names for testrail test case generation. */
	internal var preconditionStrings = [String]()
	internal var executionStrings = [String]()
	
	
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
		
		resetNameRecords()
		setup()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func resetNameRecords()
	{
		preconditionStrings = [String]()
		executionStrings = [String]()
	}
	
	
	/**
	 * Executes a given test step.
	 */
	public func given(_ step:AutumnTestStep)
	{
		self.step(AutumnStepType.Given, step)
	}
	
	
	/**
	 * Executes a when test step.
	 */
	public func when(_ step:AutumnTestStep)
	{
		self.step(AutumnStepType.When, step)
	}
	
	
	/**
	 * Executes a then test step.
	 */
	public func then(_ step:AutumnTestStep)
	{
		self.step(AutumnStepType.Then, step)
	}
	
	
	/**
	 * Executes a test step.
	 */
	internal func step(_ type:AutumnStepType, _ step:AutumnTestStep)
	{
		/* If we're in the registration phase then only record the step names for TestRail case generation,
		   don't run any actual test execution. */
		if AutumnTestRunner.phase == .CaseRegistration
		{
			let testRailStepName = "\(type.rawValue) \(step.name)."
			if type == .Given { preconditionStrings.append(testRailStepName) }
			else { executionStrings.append(testRailStepName) }
		}
		else
		{
			step.scenario = self
			step.type = type
			step.phase = phase
			steps.append(step)
			let result = step.execute()
			results.append([step:result])
		}
	}
	
	
	/**
	 * Evaluates the test step's results after all steps have been executed.
	 * Also determines the final status of the scenario.
	 */
	internal func evaluate()
	{
		var success = true
		let resultText = TabularText(4, false, " ", " ", "                   ", 0, ["PHASE", "TYPE", "NAME", "RESULT"], true)
		for record in results.enumerated()
		{
			for (step, result) in record.element
			{
				for dict in result.instructions
				{
					for (key, value) in dict
					{
						if value != .Success { success = false }
						if runner.config.logInstructions
						{
							resultText.add([step.phase.rawValue,
								"Instr",
								"\"\(key)\"",
								"\(AutumnStringConstant.RESULT_DELIMITER)\(value.rawValue)"])
						}
					}
				}
				let resultValue = result.evaluate()
				if !resultValue { success = false }
				resultText.add([step.phase.rawValue,
					"Step",
					"\"\(step.type.rawValue) \(step.name)\"",
					"\(AutumnStringConstant.RESULT_DELIMITER)\(resultValue ? AutumnTestStatus.Passed.rawValue : AutumnTestStatus.Failed.rawValue)"])
			}
		}
		
		/* Add footer row. */
		resultText.add(["Scenario",
			"",
			"",
			"\(AutumnStringConstant.RESULT_DELIMITER)\(success ? AutumnTestStatus.Passed.rawValue.uppercased() : AutumnTestStatus.Failed.rawValue.uppercased())"])
		
		AutumnLog.debug("\n\(resultText.toString())")
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
