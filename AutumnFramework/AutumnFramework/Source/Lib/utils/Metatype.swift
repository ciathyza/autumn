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


///
/// Hashable wrapper for a metatype value.
///
public struct Metatype<T> : Hashable
{
	public static func ==(lhs:Metatype, rhs:Metatype) -> Bool
	{
		return lhs.base == rhs.base
	}
	
	let base:T.Type
	
	init(_ base: T.Type)
	{
		self.base = base
	}
	
	public var hashValue:Int
	{
		return ObjectIdentifier(base).hashValue
	}
}
