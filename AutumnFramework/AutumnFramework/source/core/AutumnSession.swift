/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Ciathyza.
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
	private var _sessionTimer = ExecutionTimer()
	
	
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
		_sessionTimer.start()
		startNextFeature()
	}
	
	
	/**
	 * Marks the end of a test session.
	 */
	internal func end()
	{
		AutumnLog.debug("Ending test session ...")
		_sessionTimer.stop()
		stats.sessionDuration = _sessionTimer.time
		AutumnUI.decelerate()
		AutumnLog.debug(stats.getResultStats())
		Log.debug("Log file written to \(AutumnLog.LOGFILE_OUTPUT_PATH)")
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
			AutumnLog.debug("Starting \"\(feature.name)\" feature ...")
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
		if currentFeature != nil
		{
			_runner.session.stats.featuresExecuted += 1
			startNextFeature()
		}
		else
		{
			AutumnLog.warning("Cannot end feature! No feature was currently started.")
		}
	}
	
	
	internal func evaluateScenario(_ scenario: inout AutumnScenario) -> ScenarioResult
	{
		var success = true
		var scenarioResult = scenario.evaluate()
		
		let resultText = TabularText(4, false, " ", " ", "                   ", 0, ["PHASE", "TYPE", "NAME", "RESULT"], true)
		for row in scenarioResult.rows
		{
			if row.result != .Success { success = false }
			if _runner.config.logInstructions
			{
				resultText.add([
					row.phase.rawValue,
					row.type.rawValue,
					"\"\(row.stepType != .None ? "\(row.stepType.rawValue) " : "")\(row.name)\"",
					"\(AutumnStringConstant.RESULT_DELIMITER)\(row.type == .Step && row.result == .Success ? "Passed" : row.result.rawValue)"])
			}
		}
		
		/* Add footer row. */
		resultText.add(["Scenario", "", "",
			"\(AutumnStringConstant.RESULT_DELIMITER)\(success ? AutumnTestStatus.Passed.rawValue.uppercased() : AutumnTestStatus.Failed.rawValue.uppercased())"])
		
		scenarioResult.logText = "\n\(resultText.toString())"
		scenarioResult.success = success
		scenario.status = success ? .Passed : .Failed
		
		return scenarioResult
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Private Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Removes and returns next feature.
	 */
	private func dequeueNextFeature() -> AutumnFeature?
	{
		if (_runner.model.features.count > 0)
		{
			currentFeatureIndex += 1
			return _runner.model.features.removeFirst()
		}
		return nil
	}
}
