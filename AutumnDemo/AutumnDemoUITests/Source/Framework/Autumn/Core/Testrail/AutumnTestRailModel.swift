//
// AutumnTestRailModel.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/22.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


// ------------------------------------------------------------------------------------------------
class TestRailModel
{
	let config:AutumnConfig
	
	var projects       = [TestRailProject]()
	var suites         = [TestRailSuite]()
	var milestones     = [TestRailMilestone]()
	var testPlans      = [TestRailTestPlan]()
	var testRuns       = [TestRailTestRun]()
	var testCases      = [TestRailTestCase]()
	var statuses       = [TestRailStatus]()
	var sections       = [TestRailSection]()
	var testCaseFields = [TestRailTestCaseField]()
	var testCaseTypes  = [TestRailTestCaseType]()
	var templates      = [TestRailTemplate]()
	var tests          = [TestRailTest]()
	
	var masterSuiteID = 0
	
	/**
	 * Returns the root section used for generated test cases.
	 */
	var rootSection:TestRailSection?
	{
		for s in sections { if s.name == config.testrailRootSectionName
		{ return s } }
		return nil
	}
	
	init(_ config:AutumnConfig)
	{
		self.config = config
	}
	
	
	func getSection(_ sectionName:String) -> TestRailSection?
	{
		for s in sections
		{
			if s.name == sectionName { return s }
		}
		return nil
	}
	
	
	/**
	 * Adds a section to the model. If a section with the same name already exists it will be replaced.
	 */
	func addSection(_ section:TestRailSection)
	{
		var i = 0
		for s in sections
		{
			if s.name == section.name { sections.remove(at: i) }
			i += 1
		}
		sections.append(section)
	}
	
	
	func getTestCase(_ testCaseTitle:String) -> TestRailTestCase?
	{
		for c in testCases
		{
			if c.title == testCaseTitle { return c }
		}
		return nil
	}
	
	
	/**
	 * Adds a test case to the model. If a test case with the same title already exists it will be replaced.
	 */
	func addTestCase(_ testCase:TestRailTestCase)
	{
		var i = 0
		for c in testCases
		{
			if c.title == testCase.title { testCases.remove(at: i) }
			i += 1
		}
		testCases.append(testCase)
	}
	
	
	func getTestCaseTemplateIDFor(template:TestRailTestCaseTemplateOption) -> Int?
	{
		for i in templates
		{
			if i.name == template.rawValue { return i.id }
		}
		return nil
	}
	
	
	func getTestCaseTypeIDFor(type:TestRailTestCaseTypeOption) -> Int?
	{
		for i in testCaseTypes
		{
			if i.name == type.rawValue { return i.id }
		}
		return nil
	}
}


// ------------------------------------------------------------------------------------------------
protocol TestRailCodable : Codable
{
	func tableHeader() -> [String]
	func toTableRow() -> [String]
}


// ------------------------------------------------------------------------------------------------
struct TestRailProject : TestRailCodable
{
	let id:Int
	let suiteMode:Int
	let name:String
	let announcement:String
	let url:String
	let completedOn:Date?
	let showAnnouncement:Bool
	let isCompleted:Bool
	
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
	
	func tableHeader() -> [String]
	{
		return ["ID", "Name", "SuitMode", "Announcement", "URL"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)", "\(suiteMode)", "\(announcement)", "\(url)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailSuite : TestRailCodable
{
	let id:Int
	let projectID:Int
	let name:String
	let description:String
	let url:String
	let completedOn:Date?
	let isMaster:Bool
	let isBaseline:Bool
	let isCompleted:Bool
	
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
	
	func tableHeader() -> [String]
	{
		return ["ID", "ProjectID", "Name", "Description", "isMaster"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(projectID)", "\(name)", "\(description)", "\(isMaster)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailMilestone : TestRailCodable
{
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
	
	func tableHeader() -> [String]
	{
		return ["ID", "ProjectID", "ParentID", "Name", "Description"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(projectID)", "\(parentID)", "\(name)", "\(description)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestPlan : TestRailCodable
{
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
	
	func tableHeader() -> [String]
	{
		return ["ID", "ProjectID", "ParentID", "Name", "Description"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(projectID)", "\(parentID)", "\(name)", "\(description)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestRun : TestRailCodable
{
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
	
	func tableHeader() -> [String]
	{
		return ["ID", "ProjectID", "Name", "Description"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(projectID)", "\(name)", "\(description)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestCase : TestRailCodable
{
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
	let customPreconds:String?
	let customSteps:[String]?
	let customExpected:String?
	let customStepsSeparated:[TestRailTestCaseCustom]?
	let customMission:String?
	let customGoals:String?
	let customLabel:[String]?
	let customOS:[Int]?
	
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
		customLabel = nil
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
		do { customLabel          = try values.decode([String].self,                 forKey: .customLabel) }          catch { customLabel = nil }
		do { customOS             = try values.decode([Int].self,                    forKey: .customOS) }             catch { customOS = nil }
	}
	
	
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
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestCaseCustom : TestRailCodable
{
	let content:String
	let expected:String
	
	enum CodingKeys: String, CodingKey
	{
		case content  = "content"
		case expected = "expected"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { content  = try values.decode(String.self, forKey: .content) }  catch { content = "" }
		do { expected = try values.decode(String.self, forKey: .expected) } catch { expected = "" }
	}
	
	func tableHeader() -> [String]
	{
		return ["content", "expected"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(content)", "\(expected)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailStatus : TestRailCodable
{
	let id:Int
	let name:String
	let label:String
	let colorDark:Int
	let colorMedium:Int
	let colorBright:Int
	let isSystem:Bool
	let isUntested:Bool
	let isFinal:Bool
	
	enum CodingKeys : String, CodingKey
	{
		case id          = "id"
		case name        = "name"
		case label       = "label"
		case colorDark   = "color_dark"
		case colorMedium = "color_medium"
		case colorBright = "color_bright"
		case isSystem    = "is_system"
		case isUntested  = "is_untested"
		case isFinal     = "is_final"
	}
	
	init(from decoder:Decoder) throws
	{
		let values  = try decoder.container(keyedBy: CodingKeys.self)
		do { id          = try values.decode(Int.self,    forKey: .id) }          catch { id = 0 }
		do { name        = try values.decode(String.self, forKey: .name) }        catch { name = "" }
		do { label       = try values.decode(String.self, forKey: .label) }       catch { label = "" }
		do { colorDark   = try values.decode(Int.self,    forKey: .colorDark) }   catch { colorDark = 0 }
		do { colorMedium = try values.decode(Int.self,    forKey: .colorMedium) } catch { colorMedium = 0 }
		do { colorBright = try values.decode(Int.self,    forKey: .colorBright) } catch { colorBright = 0 }
		do { isSystem    = try values.decode(Bool.self,   forKey: .isSystem) }    catch { isSystem = false }
		do { isUntested  = try values.decode(Bool.self,   forKey: .isUntested) }  catch { isUntested = false }
		do { isFinal     = try values.decode(Bool.self,   forKey: .isFinal) }     catch { isFinal = false }
	}
	
	func tableHeader() -> [String]
	{
		return ["ID", "Name", "Label"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)", "\(label)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestCaseField : TestRailCodable
{
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
	
	enum CodingKeys : String, CodingKey
	{
		case id = "id"
		case typeID = "type_id"
		case displayOrder = "display_order"
		case templateIDs = "template_ids"
		case name = "name"
		case systemName = "system_name"
		case label = "label"
		case description = "description"
		case configs = "configs"
		case isActive = "is_active"
		case includeAll = "include_all"
	}
	
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
	
	func tableHeader() -> [String]
	{
		return ["ID", "TypeID", "Name", "Label", "TemplateIDs"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(typeID)", "\(name)", "\(label)", "\(templateIDs)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailConfig : TestRailCodable
{
	let id:Int
	let context:TestRailContext?
	let options:TestRailOptions?
	
	enum CodingKeys : String, CodingKey
	{
		case id = "id"
		case context
		case options
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id = try values.decode(Int.self, forKey: .id) } catch { id = 0 }
		do { context = try TestRailContext(from: decoder) } catch { context = nil }
		do { options = try TestRailOptions(from: decoder) } catch { options = nil }
	}
	
	func tableHeader() -> [String]
	{
		return ["ID", "context", "options"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(context)", "\(options)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailContext : TestRailCodable
{
	let projectIDs:[Int]
	let isGlobal:Bool
	
	enum CodingKeys : String, CodingKey
	{
		case projectIDs = "project_ids"
		case isGlobal   = "is_global"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { projectIDs = try values.decode([Int].self, forKey: .projectIDs) } catch { projectIDs = [Int]() }
		do { isGlobal = try values.decode(Bool.self, forKey: .isGlobal) } catch { isGlobal = false }
	}
	
	func tableHeader() -> [String]
	{
		return ["ProjectIDs", "IsGlobal"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(projectIDs)", "\(isGlobal)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailOptions : TestRailCodable
{
	let rows:String
	let defaultValue:String
	let format:String
	let isRequired:Bool
	
	enum CodingKeys : String, CodingKey
	{
		case rows         = "rows"
		case defaultValue = "default_value"
		case format       = "format"
		case isRequired   = "is_required"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { rows         = try values.decode(String.self,    forKey: .rows) }      catch { rows = "" }
		do { defaultValue = try values.decode(String.self, forKey: .defaultValue) } catch { defaultValue = "" }
		do { format       = try values.decode(String.self, forKey: .format) }       catch { format = "" }
		do { isRequired   = try values.decode(Bool.self,   forKey: .isRequired) }   catch { isRequired = false }
	}
	
	func tableHeader() -> [String]
	{
		return ["Rows", "DefaultValue", "Format", "IsRequired"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(rows)", "\(defaultValue)", "\(format)", "\(isRequired)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestCaseType : TestRailCodable
{
	let id:Int
	let name:String
	let isDefault:Bool
	
	enum CodingKeys : String, CodingKey
	{
		case id        = "id"
		case name      = "name"
		case isDefault = "is_default"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id = try values.decode(Int.self, forKey: .id) } catch { id = 0 }
		do { name = try values.decode(String.self, forKey: .name) } catch { name = "" }
		do { isDefault = try values.decode(Bool.self, forKey: .isDefault) } catch { isDefault = false }
	}
	
	func tableHeader() -> [String]
	{
		return ["id", "name", "isDefault"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)", "\(isDefault)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailPriority : TestRailCodable
{
	let id:Int
	let priority:Int
	let name:String
	let shortName:String
	let isDefault:Bool
	
	enum CodingKeys : String, CodingKey
	{
		case id        = "id"
		case priority  = "priority"
		case name      = "name"
		case shortName = "short_name"
		case isDefault = "is_default"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id        = try values.decode(Int.self,    forKey: .id) }        catch { id = 0 }
		do { priority  = try values.decode(Int.self,    forKey: .priority) }  catch { priority = 0 }
		do { name      = try values.decode(String.self, forKey: .name) }      catch { name = "'" }
		do { shortName = try values.decode(String.self, forKey: .shortName) } catch { shortName = "" }
		do { isDefault = try values.decode(Bool.self,   forKey: .isDefault) } catch { isDefault = false }
	}
	
	func tableHeader() -> [String]
	{
		return ["id", "name", "priority", "shortName", "isDefault"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)", "\(priority)", "\(shortName)", "\(isDefault)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTest : TestRailCodable
{
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
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id                   = try values.decode(Int.self,                      forKey: .id) }                   catch { id = 0 }
		do { caseID               = try values.decode(Int.self,                      forKey: .caseID) }               catch { caseID = 0 }
		do { statusID             = try values.decode(Int.self,                      forKey: .statusID) }             catch { statusID = 0 }
		do { assignedToID         = try values.decode(Int.self,                      forKey: .assignedToID) }         catch { assignedToID = 0 }
		do { runID                = try values.decode(Int.self,                      forKey: .runID) }                catch { runID = 0 }
		do { templateID           = try values.decode(Int.self,                      forKey: .templateID) }           catch { templateID = 0 }
		do { typeID               = try values.decode(Int.self,                      forKey: .typeID) }               catch { typeID = 0 }
		do { priorityID           = try values.decode(Int.self,                      forKey: .priorityID) }           catch { priorityID = 0 }
		do { milestoneID          = try values.decode(Int.self,                      forKey: .milestoneID) }          catch { milestoneID = 0 }
		do { customOS             = try values.decode([Int].self,                    forKey: .customOS) }             catch { customOS = [Int]() }
		do { title                = try values.decode(String.self,                   forKey: .title) }                catch { title = "" }
		do { estimate             = try values.decode(String.self,                   forKey: .estimate) }             catch { estimate = "" }
		do { estimateForecast     = try values.decode(String.self,                   forKey: .estimateForecast) }     catch { estimateForecast = "" }
		do { refs                 = try values.decode(String.self,                   forKey: .refs) }                 catch { refs = "" }
		do { customAutomated      = try values.decode(String.self,                   forKey: .customAutomated) }      catch { customAutomated = "" }
		do { customPreconds       = try values.decode(String.self,                   forKey: .customPreconds) }       catch { customPreconds = "" }
		do { customSteps          = try values.decode(String.self,                   forKey: .customSteps) }          catch { customSteps = "" }
		do { customExpected       = try values.decode(String.self,                   forKey: .customExpected) }       catch { customExpected = "" }
		do { customMission        = try values.decode(String.self,                   forKey: .customMission) }        catch { customMission = "" }
		do { customGoals          = try values.decode(String.self,                   forKey: .customGoals) }          catch { customGoals = "" }
		do { customLabel          = try values.decode([String].self,                 forKey: .customLabel) }          catch { customLabel = [String]() }
		do { customStepsSeparated = try values.decode([TestRailCustomTestStep].self, forKey: .customStepsSeparated) } catch { customStepsSeparated = [TestRailCustomTestStep]() }
	}
	
	func tableHeader() -> [String]
	{
		return ["ID", "Title", "CaseID", "StatusID", "AssignedToID"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(title)", "\(caseID)", "\(statusID)", "\(assignedToID)"]
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
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { content  = try values.decode(String.self, forKey: .content) } catch { content = "" }
		do { expected = try values.decode(String.self, forKey: .expected) } catch { expected = "" }
	}
	
	func tableHeader() -> [String]
	{
		return ["content", "expected"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(content)", "\(expected)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestResult : TestRailCodable
{
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
	
	func tableHeader() -> [String]
	{
		return ["id", "testID"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(testID)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailCustomTestStepResult : TestRailCodable
{
	let statusID:Int
	let content:String
	let expected:String
	let actual:String
	
	enum CodingKeys : String, CodingKey
	{
		case statusID = "status_id"
		case content  = "content"
		case expected = "expected"
		case actual   = "actual"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { statusID = try values.decode(Int.self,    forKey: .statusID) } catch { statusID = 0 }
		do { content  = try values.decode(String.self, forKey: .content) }  catch { content = "" }
		do { expected = try values.decode(String.self, forKey: .expected) } catch { expected = "" }
		do { actual   = try values.decode(String.self, forKey: .actual) }   catch { actual = "" }
	}
	
	func tableHeader() -> [String]
	{
		return ["statusID", "content"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(statusID)", "\(content)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestResultField : TestRailCodable
{
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
	
	enum CodingKeys : String, CodingKey
	{
		case id           = "id"
		case typeID       = "type_id"
		case displayOrder = "display_order"
		case templateIDs  = "template_ids"
		case configs      = "configs"
		case name         = "name"
		case systemName   = "system_name"
		case label        = "label"
		case description  = "description"
		case isActive     = "is_active"
		case includeAll   = "include_all"
	}
	
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
	
	func tableHeader() -> [String]
	{
		return ["id", "name"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailSection : TestRailCodable
{
	let id:Int
	let suiteID:Int
	let parentID:Int?
	let depth:Int
	let displayOrder:Int
	let name:String
	let description:String?
	
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
	
	init(name:String, description:String?, suiteID:Int? = nil, parentID:Int? = nil)
	{
		id = 0
		depth = 0
		displayOrder = 0
		self.name = name
		self.description = description
		self.suiteID = suiteID != nil ? suiteID! : AutumnTestRunner.instance.testRailModel.masterSuiteID
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
		return ["id", "name"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTemplate : TestRailCodable
{
	let id:Int
	let name:String
	let isDefault:Bool
	
	enum CodingKeys : String, CodingKey
	{
		case id        = "id"
		case name      = "name"
		case isDefault = "is_default"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id        = try values.decode(Int.self,    forKey: .id) }        catch { id = 0 }
		do { name      = try values.decode(String.self, forKey: .name) }      catch { name = "'" }
		do { isDefault = try values.decode(Bool.self,   forKey: .isDefault) } catch { isDefault = false }
	}
	
	func tableHeader() -> [String]
	{
		return ["ID", "Name", "IsDefault"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)", "\(isDefault)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailUser : TestRailCodable
{
	let id:Int
	let name:String
	let email:String
	let isActive:Bool
	
	enum CodingKeys : String, CodingKey
	{
		case id       = "id"
		case name     = "name"
		case email    = "email"
		case isActive = "is_active"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id = try values.decode(Int.self, forKey: .id) } catch { id = 0 }
		do { name = try values.decode(String.self, forKey: .name) } catch { name = "" }
		do { email = try values.decode(String.self, forKey: .email) } catch { email = "" }
		do { isActive = try values.decode(Bool.self, forKey: .isActive) } catch { isActive = false }
	}
	
	func tableHeader() -> [String]
	{
		return ["id", "name"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)"]
	}
}
