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
 * Represents a TestRail Priority.
 */
struct TestRailPriority : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let priority:Int
	let name:String
	let shortName:String
	let isDefault:Bool
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case id        = "id"
		case priority  = "priority"
		case name      = "name"
		case shortName = "short_name"
		case isDefault = "is_default"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id        = try values.decode(Int.self,    forKey: .id) }        catch { id = 0 }
		do { priority  = try values.decode(Int.self,    forKey: .priority) }  catch { priority = 0 }
		do { name      = try values.decode(String.self, forKey: .name) }      catch { name = "'" }
		do { shortName = try values.decode(String.self, forKey: .shortName) } catch { shortName = "" }
		do { isDefault = try values.decode(Bool.self,   forKey: .isDefault) } catch { isDefault = false }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["id", "name", "priority", "shortName", "isDefault"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)", "\(priority)", "\(shortName)", "\(isDefault)"]
	}
}
