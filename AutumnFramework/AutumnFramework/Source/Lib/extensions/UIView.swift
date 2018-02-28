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


extension UIView
{
	/**
	 * Captures an image of the current screen.
	 */
	public func captureScreen() -> UIImage
	{
		UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
		drawHierarchy(in: bounds, afterScreenUpdates: false)
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return image
	}
}
