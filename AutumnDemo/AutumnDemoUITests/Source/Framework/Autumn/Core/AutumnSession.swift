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
	internal func initialize(_ autumnSetup:AutumnTestRunner)
	{
		_runner = autumnSetup
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
		if let featureClass = dequeueNextFeatureClass()
		{
			let feature = featureClass.init(_runner)
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
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Private Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Removes and returns next feature class.
	 */
	public func dequeueNextFeatureClass() -> AutumnFeature.Type?
	{
		if (AutumnTestRunner.allFeatureClasses.count > 0)
		{
			currentFeatureIndex += 1
			return AutumnTestRunner.allFeatureClasses.removeFirst()
		}
		return nil
	}
}
