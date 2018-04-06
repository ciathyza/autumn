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
 * Represents a TestRail Plan.
 */
struct TestRailTestPlan : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let projectID:Int
	let parentID:Int
	let name:String
	let description:String
	let url:String
	let startOn:Date?
	let startedOn:Date?
	let dueOn:Date?
	let completedOn:Date?
	let isStarted:Bool
	let isCompleted:Bool
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys: String, CodingKey
	{
		case id          = "id"
		case projectID   = "project_id"
		case parentID    = "parent_id"
		case name        = "name"
		case description = "description"
		case url         = "url"
		case startOn     = "start_on"
		case startedOn   = "started_on"
		case dueOn       = "due_on"
		case completedOn = "completed_on"
		case isStarted   = "is_started"
		case isCompleted = "is_completed"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id          = try values.decode(Int.self,    forKey: .id) }                 catch { id = 0 }
		do { projectID   = try values.decode(Int.self,    forKey: .projectID) }          catch { projectID = 0 }
		do { parentID    = try values.decode(Int.self,    forKey: .parentID) }           catch { parentID = 0 }
		do { name        = try values.decode(String.self, forKey: .name) }               catch { name = "" }
		do { description = try values.decode(String.self, forKey: .description) }        catch { description = "" }
		do { url         = try values.decode(String.self, forKey: .url) }                catch { url = "" }
		do { startOn     = try values.decode(Int.self,    forKey: .startOn).toDate }     catch { startOn = nil }
		do { startedOn   = try values.decode(Int.self,    forKey: .startedOn).toDate }   catch { startedOn = nil }
		do { dueOn       = try values.decode(Int.self,    forKey: .dueOn).toDate }       catch { dueOn = nil }
		do { completedOn = try values.decode(Int.self,    forKey: .completedOn).toDate } catch { completedOn = nil }
		do { isStarted   = try values.decode(Bool.self,   forKey: .isStarted) }          catch { isStarted = false }
		do { isCompleted = try values.decode(Bool.self,   forKey: .isCompleted) }        catch { isCompleted = false }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["ID", "ProjectID", "ParentID", "Name", "Description"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(projectID)", "\(parentID)", "\(name)", "\(description)"]
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	var hashValue:Int
	{
		return 0
	}
	
	
	static func ==(lhs:TestRailTestPlan, rhs:TestRailTestPlan) -> Bool
	{
		return true
	}
}
