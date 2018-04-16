/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import Foundation


public struct AutumnTag
{
	public static let ANDROID_ONLY  = "androidonly"
	public static let FUTURE_FIX    = "futurefix"
	public static let HARDWARE_ONLY = "hardwareonly"
	public static let IOS_ONLY      = "iosonly"
	public static let PENDING       = "pending"
	public static let RETEST        = "retest"
	public static let SCOPE_OUT     = "scopeout"
	public static let UNSUPPORTED   = "unsupported"
}


public struct AutumnPrefix
{
	public static let ACTION       = "Action"
	public static let ASSERT       = "Assert"
	public static let ENTER        = "Enter"
	public static let ENV          = "Env"
	public static let PRECONDITION = "Precondition"
	public static let UI           = "UI"
	public static let WAIT         = "Wait"
}


public struct AutumnFileConstant
{
	public static let LINE_BREAK           = "\n"
	public static let SESSION_LOG_FILENAME = "Session.log"
	public static let DEBUG_LOG_FILENAME   = "Debug.log"
	public static let JSON_FILENAME        = "Session.json"
	public static let INDENTATION_LEVEL_1  = "  "
	public static let INDENTATION_LEVEL_2  = "    "
}

public struct AutumnStringConstant
{
	public static let RESULT_DELIMITER       = "--> "
	public static let TEXTFIELD_CLEAR_BUTTON = "Clear text"
}
