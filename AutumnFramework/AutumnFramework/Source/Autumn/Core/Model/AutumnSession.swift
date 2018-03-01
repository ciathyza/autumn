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
	public internal(set) var allowTearDown = false
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
}
