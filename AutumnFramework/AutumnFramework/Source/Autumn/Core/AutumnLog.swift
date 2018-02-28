//
// AutumnLog.swift
// AutumnFramework
//
// Created by Sascha, Balkau | FINAD on 2018/02/27.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation
import XCTest


/**
 * Autumn-dedicated wrapper for logging API.
 */
open class AutumnLog
{
	static let CATEGORY = "Autumn"
	
	
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
		AutumnSessionManager.instance.record(type: .Log, args: LogLevel.System, data)
	}
	
	
	public static func trace(_ data:Any)
	{
		AutumnSessionManager.instance.record(type: .Log, args: LogLevel.Trace, data)
	}
	
	
	public static func debug(_ data:Any)
	{
		AutumnSessionManager.instance.record(type: .Log, args: LogLevel.Debug, data)
	}
	
	
	public static func info(_ data:Any)
	{
		AutumnSessionManager.instance.record(type: .Log, args: LogLevel.Info, data)
	}
	
	
	public static func notice(_ data:Any)
	{
		AutumnSessionManager.instance.record(type: .Log, args: LogLevel.Notice, data)
	}
	
	
	public static func warning(_ data:Any)
	{
		AutumnSessionManager.instance.record(type: .Log, args: LogLevel.Warning, data)
	}
	
	
	public static func error(_ data:Any)
	{
		AutumnSessionManager.instance.record(type: .Log, args: LogLevel.Error, data)
	}
	
	
	public static func fatal(_ data:Any)
	{
		AutumnSessionManager.instance.record(type: .Log, args: LogLevel.Fatal, data)
	}
	
	
	public static func delimiter()
	{
		AutumnSessionManager.instance.record(type: .Log, args: LogLevel.Debug, Log.DELIMITER)
	}
	
	
	public static func delimiterStrong()
	{
		AutumnSessionManager.instance.record(type: .Log, args: LogLevel.Debug, Log.DELIMITER_STRONG)
	}
	
	
	/// Logs the complete structure of the current view hierarchy to the console.
	public class func dumpViewStructure(_ app:XCUIApplication? = nil)
	{
		if let app = app
		{
			AutumnSessionManager.instance.record(type: .Log, args: LogLevel.Debug, app.debugDescription)
			return
		}
		AutumnSessionManager.instance.record(type: .Log, args: LogLevel.Debug, AutumnTestSetup.app.debugDescription)
	}
}
