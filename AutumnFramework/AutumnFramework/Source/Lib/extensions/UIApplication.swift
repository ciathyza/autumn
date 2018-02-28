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

import UIKit


extension UIApplication
{
	public static var appVersion:String
	{
		if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
		{
			return "\(appVersion)"
		}
		return ""
	}
	
	public static var buildNumber:String
	{
		if let buildNum = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String)
		{
			return "\(buildNum)"
		}
		return ""
	}
	
	public static var versionString:String
	{
		return "\(appVersion).\(buildNumber)"
	}
}
