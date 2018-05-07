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

import Foundation


public class LogFile
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public private(set) var filePath = ""
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------

	/**
	 * Creates a new log file with given path.
	 */
	public init(_ filePath:String)
	{
		self.filePath = filePath
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Appends text data to the file. If the file doesn't exist yet, it is created.
	 */
	public func append(content:String, encoding:String.Encoding = .utf16)
	{
		if let fileHandle = FileHandle(forWritingAtPath: filePath)
		{
			fileHandle.seekToEndOfFile()
			if let data = content.data(using: encoding)
			{
				fileHandle.write(data)
				fileHandle.closeFile()
			}
		}
		else
		{
			do
			{
				try content.write(toFile: filePath, atomically: true, encoding: encoding)
			}
			catch
			{
				Log.error("", "Failed to write to \(filePath).")
			}
		}
	}
	
	
	/**
	 * Deletes the file.
	 */
	public func delete()
	{
		do
		{
			try FileManager.default.removeItem(atPath: filePath)
		}
		catch
		{
		}
	}
}
