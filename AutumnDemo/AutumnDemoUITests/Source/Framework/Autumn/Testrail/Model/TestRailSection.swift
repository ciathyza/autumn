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
 * Represents a TestRail Section.
 */
struct TestRailSection : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let suiteID:Int
	let parentID:Int?
	let depth:Int
	let displayOrder:Int
	let name:String
	let description:String?
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case id           = "id"
		case suiteID      = "suite_id"
		case parentID     = "parent_id"
		case displayOrder = "display_order"
		case depth        = "depth"
		case name         = "name"
		case description  = "description"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(name:String, description:String?, suiteID:Int? = nil, parentID:Int? = nil)
	{
		id = 0
		depth = 0
		displayOrder = 0
		self.name = name
		self.description = description
		self.suiteID = suiteID != nil ? suiteID! : AutumnTestRunner.instance.model.testrailMasterSuiteID
		self.parentID = parentID
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id           = try values.decode(Int.self,    forKey: .id) }           catch { id = 0 }
		do { suiteID      = try values.decode(Int.self,    forKey: .suiteID) }      catch { suiteID = 0 }
		do { parentID     = try values.decode(Int.self,    forKey: .parentID) }     catch { parentID = nil }
		do { depth        = try values.decode(Int.self,    forKey: .depth) }        catch { depth = 0}
		do { displayOrder = try values.decode(Int.self,    forKey: .displayOrder) } catch { displayOrder = 0 }
		do { name         = try values.decode(String.self, forKey: .name) }         catch { name = ""}
		do { description  = try values.decode(String.self, forKey: .description) }  catch { description = nil }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func encode(to encoder:Encoder) throws
	{
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id,           forKey: .id)
		try container.encode(suiteID,      forKey: .suiteID)
		try container.encode(parentID,     forKey: .parentID)
		try container.encode(depth,        forKey: .depth)
		try container.encode(displayOrder, forKey: .displayOrder)
		try container.encode(name,         forKey: .name)
		try container.encode(description,  forKey: .description)
	}
	
	
	func tableHeader() -> [String]
	{
		return ["ID", "Name", "ParentID", "Hash"]
	}
	
	
	func toTableRow() -> [String]
	{
		if let pid = parentID { return ["\(id)", "\(name)", "\(pid)", "\(hashValue)"] }
		return ["\(id)", "\(name)", "nil", "\(hashValue)"]
	}
	
	
	func isRoot() -> Bool
	{
		return name == AutumnTestRunner.instance.config.testrailRootSectionName && parentID == nil
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	var hashValue:Int
	{
		return id.hashValue
	}
	
	
	static func ==(lhs:TestRailSection, rhs:TestRailSection) -> Bool
	{
		return lhs.id == rhs.id
			&& lhs.suiteID == rhs.suiteID
			&& lhs.parentID == rhs.parentID
			&& lhs.depth == rhs.depth
			&& lhs.displayOrder == rhs.displayOrder
			&& lhs.name == rhs.name
			&& lhs.description == rhs.description
	}
}
