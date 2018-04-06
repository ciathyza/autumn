/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import Foundation


/**
 * Represents a TestRail User.
 */
struct TestRailUser : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let name:String
	let email:String
	let isActive:Bool
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case id       = "id"
		case name     = "name"
		case email    = "email"
		case isActive = "is_active"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id = try values.decode(Int.self, forKey: .id) } catch { id = 0 }
		do { name = try values.decode(String.self, forKey: .name) } catch { name = "" }
		do { email = try values.decode(String.self, forKey: .email) } catch { email = "" }
		do { isActive = try values.decode(Bool.self, forKey: .isActive) } catch { isActive = false }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["id", "name"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)"]
	}
}
