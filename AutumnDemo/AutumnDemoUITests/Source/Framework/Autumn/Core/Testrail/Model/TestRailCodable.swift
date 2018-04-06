/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import Foundation


protocol TestRailCodable : Codable, Hashable
{
	/**
	 * Returns an array of strings that represent the table header.
	 */
	func tableHeader() -> [String]
	
	/**
	 * Returns the data as a table row.
	 */
	func toTableRow() -> [String]
}
