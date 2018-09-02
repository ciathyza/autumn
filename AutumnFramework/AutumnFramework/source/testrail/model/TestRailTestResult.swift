/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Ciathyza.
 */

import Foundation


/**
 * Represents a TestRail Test Result.
 */
struct TestRailTestResult : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let testID:Int
	let createdBy:Int
	let createdOn:Date?
	let customStepResults:[TestRailCustomTestStepResult]
	
	var statusID:Int
	var comment:String?
	var version:String
	var elapsed:String
	var defects:String?
	var assignedToID:Int
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case id                = "id"
		case testID            = "test_id"
		case statusID          = "status_id"
		case createdBy         = "created_by"
		case createdOn         = "created_on"
		case assignedToID      = "assignedto_id"
		case comment           = "comment"
		case version           = "version"
		case elapsed           = "elapsed"
		case defects           = "defects"
		case customStepResults = "custom_step_results"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init()
	{
		id = 0
		testID = 0
		statusID = 0
		createdBy = 0
		createdOn = nil
		assignedToID = 0
		comment = nil
		version = ""
		elapsed = ""
		defects = nil
		customStepResults = [TestRailCustomTestStepResult]()
	}
	
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id           = try values.decode(Int.self,    forKey: .id) }               catch { id           = 0 }
		do { testID       = try values.decode(Int.self,    forKey: .testID) }           catch { testID       = 0 }
		do { statusID     = try values.decode(Int.self,    forKey: .statusID) }         catch { statusID     = 0 }
		do { createdBy    = try values.decode(Int.self,    forKey: .createdBy) }        catch { createdBy    = 0 }
		do { createdOn    = try values.decode(Int.self,    forKey: .createdOn).toDate } catch { createdOn    = nil }
		do { assignedToID = try values.decode(Int.self,    forKey: .assignedToID) }     catch { assignedToID = 0 }
		do { comment      = try values.decode(String.self, forKey: .comment) }          catch { comment      = nil }
		do { version      = try values.decode(String.self, forKey: .version) }          catch { version      = "" }
		do { elapsed      = try values.decode(String.self, forKey: .elapsed) }          catch { elapsed      = "" }
		do { defects      = try values.decode(String.self, forKey: .defects) }          catch { defects      = nil }
		do { customStepResults = try values.decode([TestRailCustomTestStepResult].self, forKey: .customStepResults) } catch { customStepResults = [TestRailCustomTestStepResult]() }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func encode(to encoder:Encoder) throws
	{
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id,                forKey: .id)
		try container.encode(testID,            forKey: .testID)
		try container.encode(statusID,          forKey: .statusID)
		try container.encode(createdBy,         forKey: .createdBy)
		try container.encode(createdOn,         forKey: .createdOn)
		try container.encode(assignedToID,      forKey: .assignedToID)
		try container.encode(comment,           forKey: .comment)
		try container.encode(version,           forKey: .version)
		try container.encode(elapsed,           forKey: .elapsed)
		try container.encode(defects,           forKey: .defects)
		try container.encode(customStepResults, forKey: .customStepResults)
	}
	
	
	func tableHeader() -> [String]
	{
		return ["ID", "TestID", "Hash"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(testID)", "\(hashValue)"]
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	var hashValue:Int
	{
		return id.hashValue
	}
	
	
	static func ==(lhs:TestRailTestResult, rhs:TestRailTestResult) -> Bool
	{
		return lhs.id == rhs.id
			&& lhs.testID == rhs.testID
			&& lhs.statusID == rhs.statusID
			&& lhs.createdBy == rhs.createdBy
			&& lhs.createdOn == rhs.createdOn
			&& lhs.assignedToID == rhs.assignedToID
			&& lhs.comment == rhs.comment
			&& lhs.version == rhs.version
			&& lhs.elapsed == rhs.elapsed
			&& lhs.defects == rhs.defects
			&& lhs.customStepResults == rhs.customStepResults
	}
}
