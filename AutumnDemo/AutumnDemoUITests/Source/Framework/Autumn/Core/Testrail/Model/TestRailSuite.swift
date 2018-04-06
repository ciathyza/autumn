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
 * Represents a TestRail Suite.
 */
struct TestRailSuite : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let projectID:Int
	let name:String
	let description:String
	let url:String
	let completedOn:Date?
	let isMaster:Bool
	let isBaseline:Bool
	let isCompleted:Bool
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys: String, CodingKey
	{
		case id          = "id"
		case projectID   = "project_id"
		case name        = "name"
		case description = "description"
		case url         = "url"
		case completedOn = "completed_on"
		case isMaster    = "is_master"
		case isBaseline  = "is_baseline"
		case isCompleted = "is_completed"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values  = try decoder.container(keyedBy: CodingKeys.self)
		do { id          = try values.decode(Int.self,    forKey: .id) }                 catch { id = 0 }
		do { projectID   = try values.decode(Int.self,    forKey: .projectID) }          catch { projectID = 0 }
		do { name        = try values.decode(String.self, forKey: .name) }               catch { name = "" }
		do { description = try values.decode(String.self, forKey: .description) }        catch { description = "" }
		do { url         = try values.decode(String.self, forKey: .url) }                catch { url = "" }
		do { completedOn = try values.decode(Int.self,    forKey: .completedOn).toDate } catch { completedOn = nil }
		do { isMaster    = try values.decode(Bool.self,   forKey: .isMaster) }           catch { isMaster = false }
		do { isBaseline  = try values.decode(Bool.self,   forKey: .isBaseline) }         catch { isBaseline = false }
		do { isCompleted = try values.decode(Bool.self,   forKey: .isCompleted) }        catch { isCompleted = false }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["ID", "ProjectID", "Name", "Description", "isMaster"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(projectID)", "\(name)", "\(description)", "\(isMaster)"]
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	var hashValue:Int
	{
		return 0
	}
	
	
	static func ==(lhs:TestRailSuite, rhs:TestRailSuite) -> Bool
	{
		return true
	}
}
