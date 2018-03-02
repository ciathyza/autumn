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
	
	public internal(set) var currentTestUser:AutumnUser?
	public internal(set) var currentFeature:AutumnFeature?
	public internal(set) var currentScenario:AutumnScenario?
	public internal(set) var currentFeatureIndex:UInt = 0
	public internal(set) var currentScenarioIndex:UInt = 0
	public internal(set) var loginAttemptCount:UInt = 0
	public internal(set) var allowTearDown = true
	
	private var _autumnSetup:AutumnSetup!
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Initializes the test session.
	 */
	internal func initialize(_ autumnSetup:AutumnSetup)
	{
		_autumnSetup = autumnSetup
	}
	
	
	/**
	 * Starts the test session.
	 */
	internal func start()
	{
		AutumnLog.debug("Starting test session ...")
		
		for i in 1 ... 50
		{
			AutumnLog.debug("Testcase \(i)")
			_autumnSetup.setUp()
			AutumnUI.launchApp()
			AutumnUI.sleep(1)
			AutumnUI.terminateApp()
			AutumnUI.sleep(1)
			_autumnSetup.tearDown()
		}
	}
	
	
	/**
	 * Marks the end of a test session.
	 */
	internal func end()
	{
		AutumnLog.debug("Ending test session ...")
		AutumnUI.sleep(2)
	}
}
