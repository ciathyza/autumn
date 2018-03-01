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


/// Manages all book-keeping tasks of Autumn by recording intermediate test data and results.
/// Also provides support for TestRail integration and JSON report generation.
class AutumnSessionManager
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Singleton Instance
	// ----------------------------------------------------------------------------------------------------
	
	static let instance = AutumnSessionManager()
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Recording API
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Records a test session action.
	 */
	public func record(type:AutumnRecordType, args:Any...)
	{
	}
}
