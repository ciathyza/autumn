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


extension NSObject
{
	public class func swizzleMethods(_ origSelector:Selector, withSelector:Selector, forClass:AnyClass)
	{
		let originalMethod = class_getInstanceMethod(forClass, origSelector)
		let swizzledMethod = class_getInstanceMethod(forClass, withSelector)
		
		method_exchangeImplementations(originalMethod!, swizzledMethod!)
	}
	
	
	public func swizzleMethods(_ origSelector:Selector, withSelector:Selector)
	{
		let aClass:AnyClass! = object_getClass(self)
		NSObject.swizzleMethods(origSelector, withSelector: withSelector, forClass: aClass)
	}
	
	
	/// Creates a new object of self with its concrete type maintained.
	///
	public func createNew() -> Self
	{
		return type(of: self).init()
	}
	
	
	public func dump() -> String
	{
		var result = "[\(String(describing: type(of: self))) "
		let mirror = Mirror(reflecting: self)
		mirror.children.forEach
		{
			child in
			result += "\n\t> \(child.label!)=\(child.value)"
		}
		return "\(result)]"
	}
	
	
	public func dumpTable() -> String
	{
		let table = TabularText(2, true, " ", " ", "", 120, ["Property", "Value"])
		let mirror = Mirror(reflecting: self)
		mirror.children.forEach
		{
			child in
			if let label = child.label
			{
				table.add([label, "\(child.value)"])
			}
		}
		return table.toString()
	}
}
