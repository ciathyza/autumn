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
 * Keeps track of all stats values.
 */
public class AutumnStats
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var launchCount:Int             = 0
	public var testUserTotal:Int           = 0
	public var viewProxiesTotal:Int        = 0
	public var featuresTotal:Int           = 0
	public var featuresExecuted:Int        = 0
	public var scenariosTotal:Int          = 0
	public var scenariosAndroidOnly:Int    = 0
	public var scenariosIOSOnly:Int        = 0
	public var scenariosCannotAutomate:Int = 0
	public var scenariosPending:Int        = 0
	public var scenariosExecuted:Int       = 0
	public var scenariosPassed:Int         = 0
	public var scenariosFailed:Int         = 0
	public var scenariosIgnored:Int        = 0
	public var scenarioRetryCount:Int      = 0
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Derrived Properties
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Number of iOS test cases that are supported.
	 */
	public var scenariosIOSEffective:Int
	{
		let v = scenariosTotal - scenariosAndroidOnly - scenariosCannotAutomate
		if (v < 0) { return 0 }
		return v
	}
	
	/**
	 * Number of Android test cases that are supported.
	 */
	public var scenariosAndroidEffective:Int
	{
		let v = scenariosTotal - scenariosIOSOnly - scenariosCannotAutomate
		if (v < 0) { return 0 }
		return v
	}
	
	/**
	 * The success rate of the current test session.
	 */
	public var successRate:Double
	{
		let v = ((Double(scenariosPassed) / Double(scenariosTotal)) * 100).rounded(1)
		if v.isNaN { return 0 }
		return v
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public func getSetupStats() -> String
	{
		let s = "\n============================================================\n"
				+ "Setup Stats:\n"
				+ "------------------------------------------------------------\n"
				+ "Test users:                  \(testUserTotal)\n"
				+ "View proxies:                \(viewProxiesTotal)\n"
				+ "Features total:              \(featuresTotal)\n"
				+ "Scenarios total:             \(scenariosTotal)\n"
				+ "Scenarios pending:           \(scenariosPending)\n"
				+ "Scenarios cannot automate:   \(scenariosCannotAutomate)\n"
				+ "Scenarios Android-only:      \(scenariosAndroidOnly)\n"
				+ "Scenarios Android effective: \(scenariosAndroidEffective)\n"
				+ "Scenarios iOS-only:          \(scenariosIOSOnly)\n"
				+ "Scenarios iOS effective:     \(scenariosIOSEffective)\n"
				+ "============================================================"
		return s
	}
	
	
	public func getResultStats() -> String
	{
		let s = "\n============================================================\n"
				+ "Result Stats:\n"
				+ "------------------------------------------------------------\n"
				+ "Test users:                  \(testUserTotal)\n"
				+ "View proxies:                \(viewProxiesTotal)\n"
				+ "Features total:              \(featuresTotal)\n"
				+ "Scenarios total:             \(scenariosTotal)\n"
				+ "Scenarios pending:           \(scenariosPending)\n"
				+ "Scenarios cannot automate:   \(scenariosCannotAutomate)\n"
				+ "Scenarios Android-only:      \(scenariosAndroidOnly)\n"
				+ "Scenarios Android effective: \(scenariosAndroidEffective)\n"
				+ "Scenarios iOS-only:          \(scenariosIOSOnly)\n"
				+ "Scenarios iOS effective:     \(scenariosIOSEffective)\n"
				+ "------------------------------------------------------------\n"
				+ "Features executed:           \(featuresExecuted)\n"
				+ "Scenarios executed:          \(scenariosExecuted)\n"
				+ "Scenarios passed:            \(scenariosPassed)\n"
				+ "Scenarios failed:            \(scenariosFailed)\n"
				+ "Scenarios ignored:           \(scenariosIgnored)\n"
				+ "Success rate:                \(successRate)%\n"
				+ "============================================================"
		return s
	}
}
