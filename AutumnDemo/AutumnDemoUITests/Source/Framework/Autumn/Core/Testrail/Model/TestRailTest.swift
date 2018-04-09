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
 * Represents a TestRail Test.
 */
struct TestRailTest : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let caseID:Int
	let statusID:Int
	let assignedToID:Int
	let runID:Int
	let templateID:Int
	let typeID:Int
	let priorityID:Int
	let milestoneID:Int
	let customOS:[Int]
	let title:String
	let estimate:String
	let estimateForecast:String
	let refs:String
	let customAutomated:String
	let customPreconds:String
	let customSteps:String
	let customExpected:String
	let customMission:String
	let customGoals:String
	let customLabel:[String]
	let customStepsSeparated:[TestRailCustomTestStep]
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case id                   = "id"
		case caseID               = "case_id"
		case statusID             = "status_id"
		case assignedToID         = "assignedto_id"
		case runID                = "run_id"
		case templateID           = "template_id"
		case typeID               = "type_id"
		case priorityID           = "priority_id"
		case milestoneID          = "milestone_id"
		case customOS             = "custom_os"
		case title                = "title"
		case estimate             = "estimate"
		case estimateForecast     = "estimate_forecast"
		case refs                 = "refs"
		case customAutomated      = "custom_automated"
		case customPreconds       = "custom_preconds"
		case customSteps          = "custom_steps"
		case customExpected       = "custom_expected"
		case customMission        = "custom_mission"
		case customGoals          = "custom_goals"
		case customLabel          = "custom_label"
		case customStepsSeparated = "custom_steps_separated"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id               = try values.decode(Int.self,      forKey: .id) }               catch { id               = 0 }
		do { caseID           = try values.decode(Int.self,      forKey: .caseID) }           catch { caseID           = 0 }
		do { statusID         = try values.decode(Int.self,      forKey: .statusID) }         catch { statusID         = 0 }
		do { assignedToID     = try values.decode(Int.self,      forKey: .assignedToID) }     catch { assignedToID     = 0 }
		do { runID            = try values.decode(Int.self,      forKey: .runID) }            catch { runID            = 0 }
		do { templateID       = try values.decode(Int.self,      forKey: .templateID) }       catch { templateID       = 0 }
		do { typeID           = try values.decode(Int.self,      forKey: .typeID) }           catch { typeID           = 0 }
		do { priorityID       = try values.decode(Int.self,      forKey: .priorityID) }       catch { priorityID       = 0 }
		do { milestoneID      = try values.decode(Int.self,      forKey: .milestoneID) }      catch { milestoneID      = 0 }
		do { customOS         = try values.decode([Int].self,    forKey: .customOS) }         catch { customOS         = [Int]() }
		do { title            = try values.decode(String.self,   forKey: .title) }            catch { title            = "" }
		do { estimate         = try values.decode(String.self,   forKey: .estimate) }         catch { estimate         = "" }
		do { estimateForecast = try values.decode(String.self,   forKey: .estimateForecast) } catch { estimateForecast = "" }
		do { refs             = try values.decode(String.self,   forKey: .refs) }             catch { refs             = "" }
		do { customAutomated  = try values.decode(String.self,   forKey: .customAutomated) }  catch { customAutomated  = "" }
		do { customPreconds   = try values.decode(String.self,   forKey: .customPreconds) }   catch { customPreconds   = "" }
		do { customSteps      = try values.decode(String.self,   forKey: .customSteps) }      catch { customSteps      = "" }
		do { customExpected   = try values.decode(String.self,   forKey: .customExpected) }   catch { customExpected   = "" }
		do { customMission    = try values.decode(String.self,   forKey: .customMission) }    catch { customMission    = "" }
		do { customGoals      = try values.decode(String.self,   forKey: .customGoals) }      catch { customGoals      = "" }
		do { customLabel      = try values.decode([String].self, forKey: .customLabel) }      catch { customLabel      = [String]() }
		do { customStepsSeparated = try values.decode([TestRailCustomTestStep].self, forKey: .customStepsSeparated) } catch { customStepsSeparated = [TestRailCustomTestStep]() }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["ID", "Title", "CaseID", "StatusID", "AssignedToID"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(title)", "\(caseID)", "\(statusID)", "\(assignedToID)"]
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	var hashValue:Int
	{
		return (31 &* id.hashValue) &+ caseID.hashValue &+ statusID.hashValue
	}
	
	
	static func ==(lhs:TestRailTest, rhs:TestRailTest) -> Bool
	{
		return lhs.id == rhs.id
			&& lhs.caseID == rhs.caseID
			&& lhs.statusID == rhs.statusID
			&& lhs.assignedToID == rhs.assignedToID
			&& lhs.runID == rhs.runID
			&& lhs.templateID == rhs.templateID
			&& lhs.typeID == rhs.typeID
			&& lhs.priorityID == rhs.priorityID
			&& lhs.milestoneID == rhs.milestoneID
			&& lhs.customOS == rhs.customOS
			&& lhs.title == rhs.title
			&& lhs.estimate == rhs.estimate
			&& lhs.estimateForecast == rhs.estimateForecast
			&& lhs.refs == rhs.refs
			&& lhs.customAutomated == rhs.customAutomated
			&& lhs.customPreconds == rhs.customPreconds
			&& lhs.customSteps == rhs.customSteps
			&& lhs.customExpected == rhs.customExpected
			&& lhs.customMission == rhs.customMission
			&& lhs.customGoals == rhs.customGoals
			&& lhs.customLabel == rhs.customLabel
			&& lhs.customSteps == rhs.customSteps
			&& lhs.customStepsSeparated == rhs.customStepsSeparated
	}
}


// ------------------------------------------------------------------------------------------------

struct TestRailCustomTestStep : TestRailCodable
{
	let content:String
	let expected:String
	
	enum CodingKeys : String, CodingKey
	{
		case content  = "content"
		case expected = "expected"
	}
	
	init(content:String, expected:String)
	{
		self.content = content
		self.expected = expected
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { content  = try values.decode(String.self, forKey: .content) } catch { content = "" }
		do { expected = try values.decode(String.self, forKey: .expected) } catch { expected = "" }
	}
	
	func encode(to encoder:Encoder) throws
	{
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(content,  forKey: .content)
		try container.encode(expected, forKey: .expected)
	}
	
	func tableHeader() -> [String]
	{
		return ["content", "expected"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(content)", "\(expected)"]
	}
	
	var hashValue:Int
	{
		return (31 &* content.hashValue) &+ expected.hashValue
	}
	
	
	static func ==(lhs:TestRailCustomTestStep, rhs:TestRailCustomTestStep) -> Bool
	{
		return lhs.content == rhs.content && lhs.expected == rhs.expected
	}
}
