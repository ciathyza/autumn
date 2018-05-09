/*
 *   __  ____  _ __
 *  / / / / /_(_) /__
 * / /_/ / __/ / (_-<
 * \____/\__/_/_/___/
 *
 * Utils & Extensions for Swiift Projects..
 * Written by Sascha Balkau
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
