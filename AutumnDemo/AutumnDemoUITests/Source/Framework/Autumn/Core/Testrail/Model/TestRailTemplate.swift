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
 * Represents a TestRail Template.
 */
struct TestRailTemplate : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let name:String
	let isDefault:Bool
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case id        = "id"
		case name      = "name"
		case isDefault = "is_default"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id        = try values.decode(Int.self,    forKey: .id) }        catch { id = 0 }
		do { name      = try values.decode(String.self, forKey: .name) }      catch { name = "'" }
		do { isDefault = try values.decode(Bool.self,   forKey: .isDefault) } catch { isDefault = false }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["ID", "Name", "IsDefault"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)", "\(isDefault)"]
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	var hashValue:Int
	{
		return 0
	}
	
	
	static func ==(lhs:TestRailTemplate, rhs:TestRailTemplate) -> Bool
	{
		return true
	}
}
