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
 * Autumn-dedicated wrapper for logging API.
 */
open class AutumnLog
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Constants
	// ----------------------------------------------------------------------------------------------------
	
	static let CATEGORY = "Autumn"
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public static func log(level:LogLevel, data:Any)
	{
		switch level
		{
			case .Trace: AutumnLog.trace(data)
			case .Debug: AutumnLog.debug(data)
			case .Info: AutumnLog.info(data)
			case .Notice: AutumnLog.notice(data)
			case .Warning: AutumnLog.warning(data)
			case .Error: AutumnLog.error(data)
			default: AutumnLog.debug(data)
		}
	}
	
	
	public static func system(_ data:Any)
	{
		Log.system(CATEGORY, data)
	}
	
	
	public static func trace(_ data:Any)
	{
		Log.trace(CATEGORY, data)
	}
	
	
	public static func debug(_ data:Any)
	{
		Log.debug(CATEGORY, data)
	}
	
	
	public static func info(_ data:Any)
	{
		Log.info(CATEGORY, data)
	}
	
	
	public static func notice(_ data:Any)
	{
		Log.notice(CATEGORY, data)
	}
	
	
	public static func warning(_ data:Any)
	{
		Log.warning(CATEGORY, data)
	}
	
	
	public static func error(_ data:Any)
	{
		Log.error(CATEGORY, data)
	}
	
	
	public static func fatal(_ data:Any)
	{
		Log.fatal(CATEGORY, data)
	}
	
	
	public static func delimiter()
	{
		Log.delimiter(CATEGORY)
	}
	
	
	public static func delimiterStrong()
	{
		Log.delimiterStrong(CATEGORY)
	}
	
	
	/**
	 * Logs the complete structure of the current view hierarchy to the console.
	 */
	public class func dumpViewStructure(_ app:XCUIApplication? = nil)
	{
		if let app = app
		{
			Log.debug(CATEGORY, app.debugDescription)
			return
		}
		Log.debug(CATEGORY, AutumnTestRunner.app.debugDescription)
	}
}
