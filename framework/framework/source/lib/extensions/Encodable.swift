/*
 *   __  ____  _ __
 *  / / / / /_(_) /__
 * / /_/ / __/ / (_-<
 * \____/\__/_/_/___/
 *
 * Utils & Extensions for Swiift Projects..
 * Written by Sascha Balkau
 */

import Foundation


extension Encodable
{
	public var dictionary:[String:Any]?
	{
		guard let data = try? JSONEncoder().encode(self) else
		{
			return nil
		}
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap
		{
			$0 as? [String:Any]
		}
	}
}
