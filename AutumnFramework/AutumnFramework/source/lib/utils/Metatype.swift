/*
 *   __  ____  _ __
 *  / / / / /_(_) /__
 * / /_/ / __/ / (_-<
 * \____/\__/_/_/___/
 *
 * Utils & Extensions for Swiift Projects..
 * Written by Ciathyza
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
