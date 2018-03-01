/*
 *   __  ____  _ __
 *  / / / / /_(_) /__
 * / /_/ / __/ / (_-<
 * \____/\__/_/_/___/
 *
 * Utils & Extensions for Swift Projects..
 *
 * Written by Sascha Balkau | ts-balkau.sascha@rakuten.com
 * Copyright (c) 2017 Rakuten, Inc. All rights reserved.
 */

import UIKit


// ------------------------------------------------------------------------------------------------
public enum LogLevel : UInt
{
	case System = 0;
	case Trace = 1;
	case Debug = 2;
	case Info = 3;
	case Notice = 4;
	case Warning = 5;
	case Error = 6;
	case Fatal = 7;
}


// ------------------------------------------------------------------------------------------------
public struct LogMode : OptionSet
{
	public let rawValue:UInt
	public init(rawValue:UInt)
	{
		self.rawValue = rawValue
	}
	
	public static let None = LogMode(rawValue: 0)
	public static let FileName = LogMode(rawValue: 1 << 0)
	public static let FuncName = LogMode(rawValue: 1 << 1)
	public static let Line = LogMode(rawValue: 1 << 2)
	public static let Date = LogMode(rawValue: 1 << 3)
	
	public static let AllOptions:LogMode = [Date, FileName, FuncName, Line]
	public static let FullCodeLocation:LogMode = [FileName, FuncName, Line]
}


// ------------------------------------------------------------------------------------------------
public struct Log
{
	public static let DELIMITER = "----------------------------------------------------------------------------------------------------"
	public static let DELIMITER_STRONG = "===================================================================================================="
	
	public static var mode:LogMode = .None
	public static var enabled = true
	public static var logLevel = LogLevel.System
	public static var prompt = "> "
	public static var separator = " "
	public static var terminator = "\n"
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Logging API
	// ----------------------------------------------------------------------------------------------------
	
	public static func system(_ category:String = ">", _ items:Any...)
	{
		if (!enabled || logLevel.rawValue > LogLevel.System.rawValue) { return }
		output(category, LogLevel.System, items: items)
	}
	
	
	public static func trace(_ category:String = ">", _ items:Any...)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Trace.rawValue) { return }
		output(category, LogLevel.Trace, items: items)
	}
	
	
	public static func debug(_ category:String = ">", _ items:Any...)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Debug.rawValue) { return }
		output(category, LogLevel.Debug, items: items)
	}
	
	
	public static func info(_ category:String = ">", _ items:Any...)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Info.rawValue) { return }
		output(category, LogLevel.Info, items: items)
	}
	
	
	public static func notice(_ category:String = ">", _ items:Any...)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Notice.rawValue) { return }
		output(category, LogLevel.Notice, items: items)
	}
	
	
	public static func warning(_ category:String = ">", _ items:Any...)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Warning.rawValue) { return }
		output(category, LogLevel.Warning, items: items)
	}
	
	
	public static func error(_ category:String = ">", _ items:Any...)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Error.rawValue) { return }
		output(category, LogLevel.Error, items: items)
	}
	
	
	public static func fatal(_ category:String = ">", _ items:Any...)
	{
		if (!enabled || logLevel.rawValue > LogLevel.Fatal.rawValue) { return }
		output(category, LogLevel.Fatal, items: items)
	}
	
	
	public static func delimiter(_ category:String = ">")
	{
		if (!enabled) { return }
		output(category, LogLevel.Trace, items: [Log.DELIMITER])
	}
	
	
	public static func delimiterStrong(_ category:String = ">")
	{
		if (!enabled) { return }
		output(category, LogLevel.Trace, items: [Log.DELIMITER_STRONG])
	}
	
	
	/**
	 * print items to the console
	 * - parameter items:      items to print
	 */
	private static func output(_ category:String, _ logLevel:LogLevel, items:[Any], _ file:String = #file, _ function:String = #function, _ line:Int = #line)
	{
		let prefix = modePrefix(Date(), file: file, function: function, line: line)
		let stringItem = items.map { "\($0)" }.joined(separator: Log.separator)
		Swift.print("\(category)\(Log.prompt)\(Log.getLogLevelName(logLevel: logLevel))\(prefix)\(stringItem)", terminator: Log.terminator)
	}
	
	
	private static func getLogLevelName(logLevel:LogLevel) -> String
	{
		switch (logLevel)
		{
			case LogLevel.System:  return " [SYSTEM]  "
			case LogLevel.Trace:   return " [TRACE]   "
			case LogLevel.Debug:   return " [DEBUG]   "
			case LogLevel.Info:    return " [INFO]    "
			case LogLevel.Notice:  return " [NOTICE]  "
			case LogLevel.Warning: return " [WARNING] "
			case LogLevel.Error:   return " [ERROR]   "
			case LogLevel.Fatal:   return " [FATAL]   "
		}
	}
}


// ------------------------------------------------------------------------------------------------
protocol RGBColorType
{
	/// Return RGB color represenation.
	/// Example R: 200, G: 125, G: 255
	var colorCode:String
	{
		get
	}
}


// ------------------------------------------------------------------------------------------------
struct ColorLog
{
	struct Key
	{
		fileprivate static let Escape = "\u{001b}["
		fileprivate static let Fg = "fg"
		static let Bg = "bg"
		
		static let StartFg = "\(Escape)\(Fg)"
		static let StartBg = "\(Escape)\(Bg)"
		
		static let ResetFG = Escape + "fg;"
		// Clear any foreground color
		static let ResetBG = Escape + "bg;"
		// Clear any background color
		static let Reset = Escape + ";"
		// Clear any foreground or background color
	}
	
	/// String with a Font color
	static func font<T>(_ color:RGBColorType, object:T) -> String
	{
		return "\(Key.StartFg)\(color.colorCode);\(object)\(Key.Reset)"
	}
	
	/// String with a Background color
	static func background<T>(_ color:RGBColorType, object:T) -> String
	{
		return "\(Key.StartBg)\(color.colorCode);\(object)\(Key.Reset)"
	}
	
	/// String with both Background and Font color
	static func colored<T>(_ font:RGBColorType, background:RGBColorType, object:T) -> String
	{
		let string =
				"\(Key.Escape)fg\(font.colorCode);" +
						"\(Key.Escape)bg\(background.colorCode);" +
						"\(object)\(Key.Reset)"
		
		return string
	}
}


// ------------------------------------------------------------------------------------------------
extension Log
{
	/// Create an output string for the currect log Mode
	static func modePrefix(_ date:Date, file:String, function:String, line:Int) -> String
	{
		var result:String = ""
		if mode.contains(.Date)
		{
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
			
			let s = formatter.string(from: date)
			result += s
		}
		if mode.contains(.FileName)
		{
			let filename = file.lastPathComponent.stringByDeletingPathExtension
			result += "\(filename)."
		}
		if mode.contains(.FuncName)
		{
			result += "\(function)"
		}
		if mode.contains(.Line)
		{
			result += "[\(line)]"
		}
		
		if !result.isEmpty
		{
			result = result.trimmingCharacters(in: CharacterSet.whitespaces)
			result += ": "
		}
		
		return result
	}
}


// ------------------------------------------------------------------------------------------------
public extension Log
{
	/// Use custom UIColor desription
	static func enableVisualColorLog()
	{
		UIColor.swizzleDescription()
	}
	
	/// Restore default UIColor desription
	static func disableVisualColorLog()
	{
		UIColor.undoDesriptionSwizzling()
	}
}
