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
 * Represents a TestRail Test Case.
 */
struct TestRailTestCase : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let suiteID:Int
	let sectionID:Int
	let title:String
	let id:Int?
	var typeID:Int?
	let milestoneID:Int?
	var templateID:Int?
	var priorityID:Int?
	let createdBy:Int?
	let updatedBy:Int?
	let refs:String?
	let estimate:String?
	let estimateForecast:String?
	let createdOn:Date?
	let updatedOn:Date?
	
	let customAutomated:Int?
	var customPreconds:String?
	let customSteps:[String]?
	let customExpected:String?
	var customStepsSeparated:[TestRailTestCaseCustom]?
	let customMission:String?
	let customGoals:String?
	let customLabel:[String]
	var customOS:[Int]?
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case id                   = "id"
		case suiteID              = "suite_id"
		case milestoneID          = "milestone_id"
		case sectionID            = "section_id"
		case templateID           = "template_id"
		case typeID               = "type_id"
		case priorityID           = "priority_id"
		case createdBy            = "created_by"
		case updatedBy            = "updated_by"
		case title                = "title"
		case refs                 = "refs"
		case estimate             = "estimate"
		case estimateForecast     = "estimate_forecast"
		case createdOn            = "created_on"
		case updatedOn            = "updated_on"
		case customAutomated      = "custom_automated"
		case customPreconds       = "custom_preconds"
		case customSteps          = "custom_steps"
		case customExpected       = "custom_expected"
		case customStepsSeparated = "custom_steps_separated"
		case customMission        = "custom_mission"
		case customGoals          = "custom_goals"
		case customLabel          = "custom_label"
		case customOS             = "custom_os"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(_ suiteID:Int, _ sectionID:Int, _ title:String)
	{
		self.suiteID = suiteID
		self.sectionID = sectionID
		self.title = title
		id = nil
		typeID = nil
		milestoneID = nil
		templateID = nil
		priorityID = nil
		createdBy = nil
		updatedBy = nil
		refs = nil
		estimate = nil
		estimateForecast = nil
		createdOn = nil
		updatedOn = nil
		customAutomated = nil
		customPreconds = nil
		customSteps = nil
		customExpected = nil
		customStepsSeparated = nil
		customMission = nil
		customGoals = nil
		customLabel = [String]()
		customOS = nil
	}
	
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { suiteID              = try values.decode(Int.self,                      forKey: .suiteID) }              catch { suiteID = 0 }
		do { sectionID            = try values.decode(Int.self,                      forKey: .sectionID) }            catch { sectionID = 0 }
		do { title                = try values.decode(String.self,                   forKey: .title) }                catch { title = "" }
		do { id                   = try values.decode(Int.self,                      forKey: .id) }                   catch { id = nil }
		do { typeID               = try values.decode(Int.self,                      forKey: .typeID) }               catch { typeID = nil }
		do { milestoneID          = try values.decode(Int.self,                      forKey: .milestoneID) }          catch { milestoneID = nil }
		do { templateID           = try values.decode(Int.self,                      forKey: .templateID) }           catch { templateID = nil }
		do { priorityID           = try values.decode(Int.self,                      forKey: .priorityID) }           catch { priorityID = nil }
		do { createdBy            = try values.decode(Int.self,                      forKey: .createdBy) }            catch { createdBy = nil }
		do { updatedBy            = try values.decode(Int.self,                      forKey: .updatedBy) }            catch { updatedBy = nil }
		do { refs                 = try values.decode(String.self,                   forKey: .refs) }                 catch { refs = nil }
		do { estimate             = try values.decode(String.self,                   forKey: .estimate) }             catch { estimate = nil }
		do { estimateForecast     = try values.decode(String.self,                   forKey: .estimateForecast) }     catch { estimateForecast = nil }
		do { createdOn            = try values.decode(Int.self,                      forKey: .createdOn).toDate }     catch { createdOn = nil }
		do { updatedOn            = try values.decode(Int.self,                      forKey: .updatedOn).toDate }     catch { updatedOn = nil }
		do { customAutomated      = try values.decode(Int.self,                      forKey: .customAutomated) }      catch { customAutomated = nil }
		do { customPreconds       = try values.decode(String.self,                   forKey: .customPreconds) }       catch { customPreconds = nil }
		do { customSteps          = try values.decode([String].self,                 forKey: .customSteps) }          catch { customSteps = nil }
		do { customExpected       = try values.decode(String.self,                   forKey: .customExpected) }       catch { customExpected = nil }
		do { customStepsSeparated = try values.decode([TestRailTestCaseCustom].self, forKey: .customStepsSeparated) } catch { customStepsSeparated = nil }
		do { customMission        = try values.decode(String.self,                   forKey: .customMission) }        catch { customMission = nil }
		do { customGoals          = try values.decode(String.self,                   forKey: .customGoals) }          catch { customGoals = nil }
		do { customLabel          = try values.decode([String].self,                 forKey: .customLabel) }          catch { customLabel = [String]() }
		do { customOS             = try values.decode([Int].self,                    forKey: .customOS) }             catch { customOS = nil }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func encode(to encoder:Encoder) throws
	{
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(suiteID,              forKey: .suiteID)
		try container.encode(sectionID,            forKey: .sectionID)
		try container.encode(title,                forKey: .title)
		try container.encode(id,                   forKey: .id)
		try container.encode(typeID,               forKey: .typeID)
		try container.encode(milestoneID,          forKey: .milestoneID)
		try container.encode(templateID,           forKey: .templateID)
		try container.encode(priorityID,           forKey: .priorityID)
		try container.encode(createdBy,            forKey: .createdBy)
		try container.encode(updatedBy,            forKey: .updatedBy)
		try container.encode(refs,                 forKey: .refs)
		try container.encode(estimate,             forKey: .estimate)
		try container.encode(estimateForecast,     forKey: .estimateForecast)
		try container.encode(createdOn,            forKey: .createdOn)
		try container.encode(updatedOn,            forKey: .updatedOn)
		try container.encode(customAutomated,      forKey: .customAutomated)
		try container.encode(customPreconds,       forKey: .customPreconds)
		try container.encode(customSteps,          forKey: .customSteps)
		try container.encode(customExpected,       forKey: .customExpected)
		try container.encode(customStepsSeparated, forKey: .customStepsSeparated)
		try container.encode(customMission,        forKey: .customMission)
		try container.encode(customGoals,          forKey: .customGoals)
		try container.encode(customLabel,          forKey: .customLabel)
		try container.encode(customOS,             forKey: .customOS)
	}
	
	func tableHeader() -> [String]
	{
		return ["ID", "SuiteID", "SectionID", "Title", "TypeID"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id!)", "\(suiteID)", "\(sectionID)", "\(title)", "\(typeID!)"]
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	var hashValue:Int
	{
		return (31 &* suiteID.hashValue) &+ sectionID.hashValue &+ title.hashValue &+ (id?.hashValue ?? 0)
	}
	
	
	static func ==(lhs:TestRailTestCase, rhs:TestRailTestCase) -> Bool
	{
		return lhs.suiteID == rhs.suiteID
			&& lhs.sectionID == rhs.sectionID
			&& lhs.title == rhs.title
			&& lhs.id == rhs.id
			&& lhs.typeID == rhs.typeID
			&& lhs.milestoneID == rhs.milestoneID
			&& lhs.templateID == rhs.templateID
			&& lhs.priorityID == rhs.priorityID
			&& lhs.createdBy == rhs.createdBy
			&& lhs.updatedBy == rhs.updatedBy
			&& lhs.refs == rhs.refs
			&& lhs.estimate == rhs.estimate
			&& lhs.estimateForecast == rhs.estimateForecast
			&& lhs.createdOn == rhs.createdOn
			&& lhs.updatedOn == rhs.updatedOn
			&& lhs.customAutomated == rhs.customAutomated
			&& lhs.customPreconds == rhs.customPreconds
			&& ((lhs.customSteps == nil && rhs.customSteps == nil) || (lhs.customSteps! == rhs.customSteps!))
			&& lhs.customExpected == rhs.customExpected
			&& ((lhs.customStepsSeparated == nil && rhs.customStepsSeparated == nil) || ((lhs.customStepsSeparated! == rhs.customStepsSeparated!)))
			&& lhs.customMission == rhs.customMission
			&& lhs.customGoals == rhs.customGoals
			&& lhs.customLabel == rhs.customLabel
			&& ((lhs.customOS == nil && rhs.customOS == nil) || (lhs.customOS! == rhs.customOS!))
	}
}


// ------------------------------------------------------------------------------------------------

/**
 * Represents a TestRail Test Case Custom.
 */
struct TestRailTestCaseCustom : TestRailCodable
{
	let content:String
	let expected:String
	
	enum CodingKeys: String, CodingKey
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
		do { content  = try values.decode(String.self, forKey: .content) }  catch { content = "" }
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
	
	static func ==(lhs:TestRailTestCaseCustom, rhs:TestRailTestCaseCustom) -> Bool
	{
		return lhs.content == rhs.content && lhs.expected == rhs.expected
	}
}
