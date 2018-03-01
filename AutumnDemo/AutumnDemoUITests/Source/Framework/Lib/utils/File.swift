/*
 *   __  ____  _ __
 *  / / / / /_(_) /__
 * / /_/ / __/ / (_-<
 * \____/\__/_/_/___/
 *
 * Utils & Extensions for Swiift Projects..
 *
 * Written by Sascha Balkau | ts-balkau.sascha@rakuten.com
 * Copyright (c) 2017 Rakuten, Inc. All rights reserved.
 */

import Foundation


public class File
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/// Appends text data to a file. If the file doesn't exist yet, it is created.
	///
	public class func append(filePath:String, content:String, encoding:String.Encoding = .utf16)
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
				Log.error("Failed to write to \(filePath).")
			}
		}
	}
	
	
	/// Deletes the file at the specified file path.
	///
	public class func delete(filePath:String)
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
