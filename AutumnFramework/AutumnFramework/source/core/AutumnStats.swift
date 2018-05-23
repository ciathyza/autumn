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
	
	public var testUserTotal:Int        = 0
	public var viewProxiesTotal:Int     = 0
	public var featuresTotal:Int        = 0
	public var featuresExecuted:Int     = 0
	public var scenariosTotal:Int       = 0
	public var scenariosUnsupported:Int = 0
	public var scenariosPending:Int     = 0
	public var scenariosStarted:Int     = 0
	public var scenariosExecuted:Int    = 0
	public var scenariosPassed:Int      = 0
	public var scenariosFailed:Int      = 0
	public var scenariosIgnored:Int     = 0
	public var sessionDuration          = ""
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Derrived Properties
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Number of test cases that can be tested.
	 */
	public var scenariosEffective:Int
	{
		let v = scenariosTotal - scenariosUnsupported
		if (v < 0) { return 0 }
		return v
	}
	
	
	/**
	 * The success rate of the current test session.
	 */
	public var successRate:Double
	{
		let v = ((Double(scenariosPassed) / Double(scenariosStarted)) * 100).rounded(1)
		if v.isNaN { return 0 }
		return v
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public func getSetupStats() -> String
	{
		let table = TabularText(2, false, "  ", " ", "                   ", 0, ["Stat", "Count"], false)
		table.add(["Test users", "\(testUserTotal)"])
		table.add(["View proxies", "\(viewProxiesTotal)"])
		table.add(["Features total", "\(featuresTotal)"])
		table.add(["Scenarios total", "\(scenariosTotal)"])
		table.add(["Scenarios pending", "\(scenariosPending)"])
		table.add(["Scenarios unsupported", "\(scenariosUnsupported)"])
		table.add(["Scenarios effective", "\(scenariosEffective)"])
		return "\n\(table.toString())"
	}
	
	
	public func getResultStats() -> String
	{
		let table = TabularText(2, false, "  ", " ", "                   ", 0, ["Stat", "Count"], false)
		table.add(["Session duration", "\(sessionDuration)"])
		table.add(["Features total", "\(featuresTotal)"])
		table.add(["Features executed", "\(featuresExecuted)"])
		table.add(["Scenarios total", "\(scenariosTotal)"])
		table.add(["Scenarios pending", "\(scenariosPending)"])
		table.add(["Scenarios unsupported", "\(scenariosUnsupported)"])
		table.add(["Scenarios effective", "\(scenariosEffective)"])
		table.add(["Scenarios started", "\(scenariosStarted)"])
		table.add(["Scenarios executed", "\(scenariosExecuted)"])
		table.add(["Scenarios passed", "\(scenariosPassed)"])
		table.add(["Scenarios failed", "\(scenariosFailed)"])
		table.add(["Scenarios ignored", "\(scenariosIgnored)"])
		table.add(["Success rate", "\(successRate)%"])
		return "\n\(table.toString())"
	}
}
