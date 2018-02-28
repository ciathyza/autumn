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


extension UIDevice
{
	/// Checks whether the app is currently running on simulator or not.
	///
	public static var isSimulator:Bool
	{
		return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
	}
}
