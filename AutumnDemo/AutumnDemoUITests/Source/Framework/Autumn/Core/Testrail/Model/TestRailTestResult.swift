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
 * Represents a TestRail Test Result.
 */
struct TestRailTestResult : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let testID:Int
	let statusID:Int
	let createdBy:Int
	let createdOn:Date?
	let assignedToID:Int
	let comment:String
	let version:String
	let elapsed:String
	let defects:String
	let customStepResults:[TestRailCustomTestStepResult]
	
	
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
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id                = try values.decode(Int.self,                            forKey: .id) }                catch { id = 0 }
		do { testID            = try values.decode(Int.self,                            forKey: .testID) }            catch { testID = 0 }
		do { statusID          = try values.decode(Int.self,                            forKey: .statusID) }          catch { statusID = 0 }
		do { createdBy         = try values.decode(Int.self,                            forKey: .createdBy) }         catch { createdBy = 0 }
		do { createdOn         = try values.decode(Int.self,                            forKey: .createdOn).toDate }  catch { createdOn = nil }
		do { assignedToID      = try values.decode(Int.self,                            forKey: .assignedToID) }      catch { assignedToID = 0 }
		do { comment           = try values.decode(String.self,                         forKey: .comment) }           catch { comment = "" }
		do { version           = try values.decode(String.self,                         forKey: .version) }           catch { version = "" }
		do { elapsed           = try values.decode(String.self,                         forKey: .elapsed) }           catch { elapsed = "" }
		do { defects           = try values.decode(String.self,                         forKey: .defects) }           catch { defects = ""}
		do { customStepResults = try values.decode([TestRailCustomTestStepResult].self, forKey: .customStepResults) } catch { customStepResults = [TestRailCustomTestStepResult]() }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["id", "testID"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(testID)"]
	}
}
