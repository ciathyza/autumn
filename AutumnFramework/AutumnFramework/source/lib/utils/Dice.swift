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


public class Dice
{
	/**
	 * Rolls a set of dice with the specified maximum number.
	 *
	 * @param maxValue The maximum value of a single die.
	 * @param diceCount The amount of dice to roll.
	 * @return The rolled die.
	 */
	public class func roll(maxValue:UInt, diceCount:UInt = 1) -> UInt
	{
		var v:UInt = 0;
		for _ in 0 ..< diceCount
		{
			v += UInt.random(inRange: 1...maxValue)
		}
		return v;
	}
}
