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


extension Bundle
{
	var versionString:String?
	{
		return infoDictionary?["CFBundleShortVersionString"] as? String
	}
	
	var versionStringPretty:String
	{
		return "\(versionString ?? "1.0.0")"
	}
	
	var buildNumberString:String?
	{
		return infoDictionary?["CFBundleVersion"] as? String
	}
}
