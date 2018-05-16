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


// ----------------------------------------------------------------------------------------------------
// MARK: - Structs
// ----------------------------------------------------------------------------------------------------

/**
 * Struct used for scenario results.
 */
struct ScenarioResult
{
	var scenario:AutumnScenario!
	var rows = [ScenarioResultRow]()
	var logText = ""
	var success = false
}


/**
 * Struct used for scenario result rows.
 */
struct ScenarioResultRow
{
	var phase    = AutumnScenarioPhase.None
	var type     = AutumnScenarioInstructionType.Instr
	var stepType = AutumnStepType.None
	var name     = ""
	var result   = AutumnUIActionResult.Failed
}


/**
 * Represents a test scenario that defines test steps.
 *
 * Use this class by creating sub-classes and overriding setup(), establish(), and execute().
 * Then in setup() specify the properties such as ID, title, status, etc. for the scenario.
 * In establish() you should add Given declarations that establish the required state for
 * the test, such as launching the app, navigating to the desired view, etc.
 * In execute() you should define the actual test steps by adding When/Then declarations.
 * A When declaration determines an action and a Then declaration determines an assert.
 * Every When declaration should be followed by one or more Then declartions.
 */
open class AutumnScenario : AutumnHashable
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
	
	public var id       = ""
	public var title    = ""
	public var descr    = ""
	public var link     = ""
	public var tags     = [String]()
	public var priority = TestRailTestCasePriorityOption.Medium
	public var estimate:String?
	public var elapsed:String?
	public var status = AutumnTestStatus.None
	public var unsupportedReason = AutumnUnsupportedReason.None
	
	public var uninstallBefore = true
	public var resetBefore     = false
	public var resetAfter      = false
	public var terminateAfter  = true
	
	public private(set) var feature:AutumnFeature
	public private(set) var app:XCUIApplication
	public private(set) var runner:AutumnTestRunner
	
	internal var phase = AutumnScenarioPhase.None
	
	internal private(set) var steps = [AutumnTestStep]()
	internal private(set) var results = [(step:AutumnTestStep, result:AutumnTestStepResult)]()
	internal private(set) var result = ScenarioResult()
	
	/* Used to store precondition (given) and execution (when/then) step names for testrail test case generation. */
	internal var preconditionStrings = [String]()
	internal var executionStrings = [String]()
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Derrived Properties
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Scenario tags as a comma-separated string.
	 */
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
	 * Initializes a new scenario.
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
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	public var hashValue:Int
	{
		return title.hashValue
	}
	
	
	public static func ==(lhs:AutumnScenario, rhs:AutumnScenario) -> Bool
	{
		return lhs.title == rhs.title
			&& lhs.link == rhs.link
			&& lhs.tags.description == rhs.tags.description
			&& lhs.priority == rhs.priority
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
		if AutumnTestRunner.phase == .DataRegistration || AutumnTestRunner.phase == .DataSync
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
			results.append((step: step, result: result))
		}
	}
	
	
	/**
	 * Evaluates the test step's results after all steps have been executed.
	 * Also determines the final status of the scenario.
	 */
	internal func evaluate() -> ScenarioResult
	{
		result = ScenarioResult()
		
		/* Loop through all scenario steps. */
		for (step, stepResult) in results
		{
			/* Loop through all instructions of the step. */
			for (instruction, instructionResult) in stepResult.instructions
			{
				var evaluation = ScenarioResultRow()
				evaluation.phase = step.phase
				evaluation.type = .Instr
				evaluation.name = instruction
				evaluation.result = instructionResult
				result.rows.append(evaluation)
			}
			
			/* Add actual step. */
			var evaluation = ScenarioResultRow()
			evaluation.phase = step.phase
			evaluation.type = .Step
			evaluation.stepType = step.type
			evaluation.name = step.name
			evaluation.result = stepResult.evaluate() ? AutumnUIActionResult.Success : AutumnUIActionResult.Failed
			result.rows.append(evaluation)
		}
		
		return result
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
