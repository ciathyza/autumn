/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import Foundation


/**
 * Maintains the state of all test session-related data.
 */
internal class AutumnSession
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Internal Methods
	// ----------------------------------------------------------------------------------------------------
	
	internal var stats = AutumnStats()
	
	public internal(set) var defaultUserSTG:AutumnUser?
	public internal(set) var defaultUserPRD:AutumnUser?
	public internal(set) var currentTestUser:AutumnUser?
	
	public internal(set) var currentFeature:AutumnFeature?
	public internal(set) var currentScenario:AutumnScenario?
	
	public internal(set) var currentFeatureIndex:UInt = 0
	public internal(set) var currentScenarioIndex:UInt = 0
	public internal(set) var loginAttemptCount:UInt = 0
	public internal(set) var allowTearDown = true
	
	private var _runner:AutumnTestRunner!
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Internal Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Initializes the test session.
	 */
	internal func initialize(_ runner:AutumnTestRunner)
	{
		_runner = runner
	}
	
	
	/**
	 * Starts the test session.
	 */
	internal func start()
	{
		AutumnLog.debug("Starting test session ...")
		startNextFeature()
	}
	
	
	/**
	 * Marks the end of a test session.
	 */
	internal func end()
	{
		AutumnLog.debug("Ending test session ...")
		AutumnUI.decelerate()
	}
	
	
	/**
	 * Starts a feature. If no feature class was given it will start the next in the queue.
	 */
	internal func startFeature(_ featureClass:AutumnFeature.Type? = nil)
	{
		if let clazz = featureClass
		{
			let feature = clazz.init(_runner)
			currentFeature = feature
			feature.preLaunch()
		}
		else
		{
			/* Without a specified feature class, start with the next registered feature class. */
			startNextFeature()
		}
	}
	
	
	/**
	 * Starts the next feature in the queue.
	 */
	internal func startNextFeature()
	{
		if let feature = dequeueNextFeature()
		{
			currentFeature = feature
			feature.preLaunch()
			feature.start()
		}
		else
		{
			/* No more features in queue! */
			end()
		}
	}
	
	
	/**
	 * Ends the currently running feature.
	 */
	internal func endFeature()
	{
		if let feature = currentFeature
		{
			feature.end()
		}
		else
		{
			AutumnLog.warning("Cannot end feature! No feature was currently started.")
		}
	}
	
	
	internal func evaluateScenarioResults(_ scenarioResult:ScenarioResult)
	{
		var success = true
		let resultText = TabularText(4, false, " ", " ", "                   ", 0, ["PHASE", "TYPE", "NAME", "RESULT"], true)
		for result in scenarioResult.rows
		{
			if result.result != .Success { success = false }
			if _runner.config.logInstructions
			{
				resultText.add([
					result.phase.rawValue,
					result.type.rawValue,
					"\"\(result.name)\"",
					"\(AutumnStringConstant.RESULT_DELIMITER)\(result.type == .Step && result.result == .Success ? "Passed" : result.result.rawValue)"])
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
	// MARK: - Private Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Removes and returns next feature.
	 */
	public func dequeueNextFeature() -> AutumnFeature?
	{
		if (_runner.model.features.count > 0)
		{
			currentFeatureIndex += 1
			return _runner.model.features.removeFirst()
		}
		return nil
	}
}
