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
 * Represents a TestRail Test Run.
 */
struct TestRailTestRun : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let suiteID:Int
	let projectID:Int
	let milestoneID:Int
	let planID:Int
	let assignedToID:Int
	let createdBy:Int
	let passedCount:Int
	let blockedCount:Int
	let untestedCount:Int
	let retestCount:Int
	let failedCount:Int
	let customStatus1Count:Int
	let customStatus2Count:Int
	let customStatus3Count:Int
	let customStatus4Count:Int
	let customStatus5Count:Int
	let customStatus6Count:Int
	let customStatus7Count:Int
	let name:String
	let description:String
	let url:String
	let config:String
	let configIDs:[Int]
	let completedOn:Date?
	let createdOn:Date?
	let includeAll:Bool
	let isCompleted:Bool
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case id                 = "id"
		case projectID          = "project_id"
		case suiteID            = "suite_id"
		case milestoneID        = "milestone_id"
		case planID             = "plan_id"
		case assignedToID       = "assignedto_id"
		case createdBy          = "created_by"
		case passedCount        = "passed_count"
		case blockedCount       = "blocked_count"
		case untestedCount      = "untested_count"
		case retestCount        = "retest_count"
		case failedCount        = "failed_count"
		case customStatus1Count = "custom_status1_count"
		case customStatus2Count = "custom_status2_count"
		case customStatus3Count = "custom_status3_count"
		case customStatus4Count = "custom_status4_count"
		case customStatus5Count = "custom_status5_count"
		case customStatus6Count = "custom_status6_count"
		case customStatus7Count = "custom_status7_count"
		case name               = "name"
		case description        = "description"
		case url                = "url"
		case config             = "config"
		case configIDs          = "config_ids"
		case completedOn        = "completed_on"
		case createdOn          = "created_on"
		case includeAll         = "include_all"
		case isCompleted        = "is_completed"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id                 = try values.decode(Int.self,      forKey: .id) }                 catch { id = 0 }
		do { projectID          = try values.decode(Int.self,      forKey: .projectID) }          catch { projectID = 0 }
		do { suiteID            = try values.decode(Int.self,      forKey: .suiteID) }            catch { suiteID = 0 }
		do { milestoneID        = try values.decode(Int.self,      forKey: .milestoneID) }        catch { milestoneID = 0 }
		do { planID             = try values.decode(Int.self,      forKey: .planID) }             catch { planID = 0 }
		do { assignedToID       = try values.decode(Int.self,      forKey: .assignedToID) }       catch { assignedToID = 0 }
		do { createdBy          = try values.decode(Int.self,      forKey: .createdBy) }          catch { createdBy = 0 }
		do { passedCount        = try values.decode(Int.self,      forKey: .passedCount) }        catch { passedCount = 0 }
		do { blockedCount       = try values.decode(Int.self,      forKey: .blockedCount) }       catch { blockedCount = 0 }
		do { untestedCount      = try values.decode(Int.self,      forKey: .untestedCount) }      catch { untestedCount = 0 }
		do { retestCount        = try values.decode(Int.self,      forKey: .retestCount) }        catch { retestCount = 0 }
		do { failedCount        = try values.decode(Int.self,      forKey: .failedCount) }        catch { failedCount = 0 }
		do { customStatus1Count = try values.decode(Int.self,      forKey: .customStatus1Count) } catch { customStatus1Count = 0 }
		do { customStatus2Count = try values.decode(Int.self,      forKey: .customStatus2Count) } catch { customStatus2Count = 0 }
		do { customStatus3Count = try values.decode(Int.self,      forKey: .customStatus3Count) } catch { customStatus3Count = 0 }
		do { customStatus4Count = try values.decode(Int.self,      forKey: .customStatus4Count) } catch { customStatus4Count = 0 }
		do { customStatus5Count = try values.decode(Int.self,      forKey: .customStatus5Count) } catch { customStatus5Count = 0 }
		do { customStatus6Count = try values.decode(Int.self,      forKey: .customStatus6Count) } catch { customStatus6Count = 0 }
		do { customStatus7Count = try values.decode(Int.self,      forKey: .customStatus7Count) } catch { customStatus7Count = 0 }
		do { name               = try values.decode(String.self,   forKey: .name) }               catch { name = "" }
		do { description        = try values.decode(String.self,   forKey: .description) }        catch { description = "" }
		do { url                = try values.decode(String.self,   forKey: .url) }                catch { url = "" }
		do { config             = try values.decode(String.self,   forKey: .config) }             catch { config = "" }
		do { configIDs          = try values.decode([Int].self,    forKey: .configIDs) }          catch { configIDs = [Int]() }
		do { completedOn        = try values.decode(Int.self,      forKey: .completedOn).toDate } catch { completedOn = nil }
		do { createdOn          = try values.decode(Int.self,      forKey: .createdOn).toDate }   catch { createdOn = nil }
		do { includeAll         = try values.decode(Bool.self,     forKey: .includeAll) }         catch { includeAll = false }
		do { isCompleted        = try values.decode(Bool.self,     forKey: .isCompleted) }        catch { isCompleted = false }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["ID", "ProjectID", "Name", "Description"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(projectID)", "\(name)", "\(description)"]
	}
}
