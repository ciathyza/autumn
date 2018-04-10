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
 * Represents a TestRail Test Case Field.
 */
struct TestRailTestCaseField : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let typeID:Int
	let displayOrder:Int
	let templateIDs:[Int]
	let name:String
	let systemName:String
	let label:String
	let description:String
	let configs:[TestRailConfig]
	let isActive:Bool
	let includeAll:Bool
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case id           = "id"
		case typeID       = "type_id"
		case displayOrder = "display_order"
		case templateIDs  = "template_ids"
		case name         = "name"
		case systemName   = "system_name"
		case label        = "label"
		case description  = "description"
		case configs      = "configs"
		case isActive     = "is_active"
		case includeAll   = "include_all"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id           = try values.decode(Int.self,              forKey: .id) }           catch { id = 0 }
		do { typeID       = try values.decode(Int.self,              forKey: .typeID) }       catch { typeID = 0 }
		do { displayOrder = try values.decode(Int.self,              forKey: .displayOrder) } catch { displayOrder = 0 }
		do { templateIDs  = try values.decode([Int].self,            forKey: .templateIDs) }  catch { templateIDs = [Int]() }
		do { name         = try values.decode(String.self,           forKey: .name) }         catch { name = "" }
		do { systemName   = try values.decode(String.self,           forKey: .systemName) }   catch { systemName = "" }
		do { label        = try values.decode(String.self,           forKey: .label) }        catch { label = "" }
		do { description  = try values.decode(String.self,           forKey: .description) }  catch { description = "" }
		do { configs      = try values.decode([TestRailConfig].self, forKey: .configs) }      catch { configs = [TestRailConfig]() }
		do { isActive     = try values.decode(Bool.self,             forKey: .isActive) }     catch { isActive = false }
		do { includeAll   = try values.decode(Bool.self,             forKey: .includeAll) }   catch { includeAll = false }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["ID", "TypeID", "Name", "Label", "TemplateIDs", "Hash"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(typeID)", "\(name)", "\(label)", "\(templateIDs)", "\(hashValue)"]
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	var hashValue:Int
	{
		return id.hashValue
	}
	
	
	static func ==(lhs:TestRailTestCaseField, rhs:TestRailTestCaseField) -> Bool
	{
		return lhs.id == rhs.id
			&& lhs.typeID == rhs.typeID
			&& lhs.displayOrder == rhs.displayOrder
			&& lhs.templateIDs == rhs.templateIDs
			&& lhs.name == rhs.name
			&& lhs.systemName == rhs.systemName
			&& lhs.label == rhs.label
			&& lhs.description == rhs.description
			&& lhs.configs == rhs.configs
			&& lhs.isActive == rhs.isActive
			&& lhs.includeAll == rhs.includeAll
	}
}
