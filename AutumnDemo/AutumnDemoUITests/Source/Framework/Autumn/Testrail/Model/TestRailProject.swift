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
 * Represents a TestRail Project.
 */
struct TestRailProject : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let suiteMode:Int
	let name:String
	let announcement:String
	let url:String
	let completedOn:Date?
	let showAnnouncement:Bool
	let isCompleted:Bool
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys: String, CodingKey
	{
		case id               = "id"
		case suiteMode        = "suite_mode"
		case name             = "name"
		case announcement     = "announcement"
		case url              = "url"
		case completedOn      = "completed_on"
		case showAnnouncement = "show_announcement"
		case isCompleted      = "is_completed"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id               = try values.decode(Int.self,    forKey: .id) }                 catch { id = 0 }
		do { suiteMode        = try values.decode(Int.self,    forKey: .suiteMode) }          catch { suiteMode = 0 }
		do { name             = try values.decode(String.self, forKey: .name) }               catch { name = "" }
		do { announcement     = try values.decode(String.self, forKey: .announcement) }       catch { announcement = "" }
		do { url              = try values.decode(String.self, forKey: .url) }                catch { url = "" }
		do { completedOn      = try values.decode(Int.self,    forKey: .completedOn).toDate } catch { completedOn = nil }
		do { showAnnouncement = try values.decode(Bool.self,   forKey: .showAnnouncement) }   catch { showAnnouncement = false }
		do { isCompleted      = try values.decode(Bool.self,   forKey: .isCompleted) }        catch { isCompleted = false }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["ID", "Name", "SuitMode", "Announcement", "Hash"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)", "\(suiteMode)", "\(announcement)", "\(hashValue)"]
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	var hashValue:Int
	{
		return id.hashValue
	}
	
	
	static func ==(lhs:TestRailProject, rhs:TestRailProject) -> Bool
	{
		return lhs.id == rhs.id
			&& lhs.suiteMode == rhs.suiteMode
			&& lhs.name == rhs.name
			&& lhs.announcement == rhs.announcement
			&& lhs.url == rhs.url
			&& lhs.completedOn == rhs.completedOn
			&& lhs.showAnnouncement == rhs.showAnnouncement
			&& lhs.isCompleted == rhs.isCompleted
	}
}
