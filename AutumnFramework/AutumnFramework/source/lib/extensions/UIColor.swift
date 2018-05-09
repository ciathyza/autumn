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


/**
 * RBG Color structure.
 */
public struct RGBColor
{
	let R:Int
	let G:Int
	let B:Int
}


/**
 * UI Color extensions.
 */
extension UIColor
{
	public var rgbColor:RGBColor
	{
		var red:CGFloat = 0
		var green:CGFloat = 0
		var blue:CGFloat = 0
		var alpha:CGFloat = 0
		
		getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		return RGBColor(R: Int(red * 255), G: Int(green * 255), B: Int(blue * 255))
	}
	
	
	@objc func colorDescription() -> String
	{
		let color = rgbColor
		return "\(color) - " + ColorLog.background(color, object: " ")
	}
	
	
	/**
	 * Swizzle description method with own colorDescription. colorDescription will used instead of description.
	 */
	public class func swizzleDescription()
	{
		let instance = UIColor.red
		instance.swizzleMethods(#selector(getter:NSObjectProtocol.description), withSelector: #selector(UIColor.colorDescription))
	}
	
	
	/**
	 * Restore back original description method.
	 */
	public class func undoDesriptionSwizzling()
	{
		let instance = UIColor.red
		instance.swizzleMethods(#selector(UIColor.colorDescription), withSelector: #selector(getter:NSObjectProtocol.description))
	}
}


// ------------------------------------------------------------------------------------------------
extension RGBColor : CustomStringConvertible
{
	public var description:String
	{
		return "RGB: \(R), \(G), \(B)"
	}
}


// ------------------------------------------------------------------------------------------------
extension RGBColor : RGBColorType
{
	/**
	 * Color representation for XcodeColors console log.
	 */
	public var colorCode:String
	{
		return "\(R),\(G),\(B)"
	}
}
