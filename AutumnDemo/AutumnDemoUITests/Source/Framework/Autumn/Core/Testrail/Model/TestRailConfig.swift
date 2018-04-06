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
 * Represents a TestRail Config.
 */
struct TestRailConfig : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let context:TestRailContext?
	let options:TestRailOptions?
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case id = "id"
		case context
		case options
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id = try values.decode(Int.self, forKey: .id) } catch { id = 0 }
		do { context = try TestRailContext(from: decoder) } catch { context = nil }
		do { options = try TestRailOptions(from: decoder) } catch { options = nil }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["ID", "context", "options"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(context)", "\(options)"]
	}
}


// ------------------------------------------------------------------------------------------------

struct TestRailContext : TestRailCodable
{
	let projectIDs:[Int]
	let isGlobal:Bool
	
	enum CodingKeys : String, CodingKey
	{
		case projectIDs = "project_ids"
		case isGlobal   = "is_global"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { projectIDs = try values.decode([Int].self, forKey: .projectIDs) } catch { projectIDs = [Int]() }
		do { isGlobal = try values.decode(Bool.self, forKey: .isGlobal) } catch { isGlobal = false }
	}
	
	func tableHeader() -> [String]
	{
		return ["ProjectIDs", "IsGlobal"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(projectIDs)", "\(isGlobal)"]
	}
}


// ------------------------------------------------------------------------------------------------

struct TestRailOptions : TestRailCodable
{
	let rows:String
	let defaultValue:String
	let format:String
	let isRequired:Bool
	
	enum CodingKeys : String, CodingKey
	{
		case rows         = "rows"
		case defaultValue = "default_value"
		case format       = "format"
		case isRequired   = "is_required"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { rows         = try values.decode(String.self,    forKey: .rows) }      catch { rows = "" }
		do { defaultValue = try values.decode(String.self, forKey: .defaultValue) } catch { defaultValue = "" }
		do { format       = try values.decode(String.self, forKey: .format) }       catch { format = "" }
		do { isRequired   = try values.decode(Bool.self,   forKey: .isRequired) }   catch { isRequired = false }
	}
	
	func tableHeader() -> [String]
	{
		return ["Rows", "DefaultValue", "Format", "IsRequired"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(rows)", "\(defaultValue)", "\(format)", "\(isRequired)"]
	}
}
