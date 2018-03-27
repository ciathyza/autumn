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
	var masterSuiteID = ""
	
	var projects   = [TestRailProject]()
	var suites     = [TestRailSuite]()
	var milestones = [TestRailMilestone]()
	var testPlans  = [TestRailTestPlan]()
	var testRuns   = [TestRailTestRun]()
	var testCases  = [TestRailTestCase]()
}


// ------------------------------------------------------------------------------------------------
struct TestRailProject : Codable
{
	let id:Int?
	let name:String?
	let announcement:String?
	let showAnnouncement:Bool?
	let isCompleted:Bool?
	let completedOn:String?
	let suiteMode:Int?
	let url:String?
	
	enum CodingKeys: String, CodingKey
	{
		case id               = "id"
		case name             = "name"
		case announcement     = "announcement"
		case showAnnouncement = "show_announcement"
		case isCompleted      = "is_completed"
		case completedOn      = "completed_on"
		case suiteMode        = "suite_mode"
		case url              = "url"
	}
	
	init(from decoder:Decoder) throws
	{
		let values       = try decoder.container(keyedBy: CodingKeys.self)
		id               = try values.decodeIfPresent(Int.self,    forKey: .id)
		name             = try values.decodeIfPresent(String.self, forKey: .name)
		announcement     = try values.decodeIfPresent(String.self, forKey: .announcement)
		showAnnouncement = try values.decodeIfPresent(Bool.self,   forKey: .showAnnouncement)
		isCompleted      = try values.decodeIfPresent(Bool.self,   forKey: .isCompleted)
		completedOn      = try values.decodeIfPresent(String.self, forKey: .completedOn)
		suiteMode        = try values.decodeIfPresent(Int.self,    forKey: .suiteMode)
		url              = try values.decodeIfPresent(String.self, forKey: .url)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailSuite : Codable
{
	let id:Int?
	let name:String?
	let description:String?
	let projectID:Int?
	let isMaster:Bool?
	let isBaseline:Bool?
	let isCompleted:Bool?
	let completedOn:String?
	let url:String?
	
	enum CodingKeys: String, CodingKey
	{
		case id          = "id"
		case name        = "name"
		case description = "description"
		case projectID   = "project_id"
		case isMaster    = "is_master"
		case isBaseline  = "is_baseline"
		case isCompleted = "is_completed"
		case completedOn = "completed_on"
		case url         = "url"
	}
	
	init(from decoder:Decoder) throws
	{
		let values  = try decoder.container(keyedBy: CodingKeys.self)
		id          = try values.decodeIfPresent(Int.self,    forKey: .id)
		name        = try values.decodeIfPresent(String.self, forKey: .name)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		projectID   = try values.decodeIfPresent(Int.self,    forKey: .projectID)
		isMaster    = try values.decodeIfPresent(Bool.self,   forKey: .isMaster)
		isBaseline  = try values.decodeIfPresent(Bool.self,   forKey: .isBaseline)
		isCompleted = try values.decodeIfPresent(Bool.self,   forKey: .isCompleted)
		completedOn = try values.decodeIfPresent(String.self, forKey: .completedOn)
		url         = try values.decodeIfPresent(String.self, forKey: .url)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailMilestone : Codable
{
	let id:Int
	let projectID:Int
	let parentID:Int?
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
		
		do    { id = try values.decode(Int.self, forKey: .id) }
		catch { id = try values.decode(String.self, forKey: .id).toInt }
		catch { id = 0 }
		do    { projectID = try values.decode(Int.self, forKey: .projectID) }
		catch { projectID = 0 }
		do    { parentID = try values.decode(Int.self, forKey: .parentID) }
		catch { parentID = nil }
		
		do    { name = try values.decode(String.self, forKey: .name) }
		catch { name = "" }
		do    { description = try values.decode(String.self, forKey: .description) }
		catch { description = "" }
		do    { url = try values.decode(String.self, forKey: .url) }
		catch { url = "" }
		
		do    { startOn = try values.decode(Int.self, forKey: .startOn).toDate }
		catch { startOn = nil }
		do    { startedOn = try values.decode(Int.self, forKey: .startedOn).toDate }
		catch { startedOn = nil }
		do    { dueOn = try values.decode(Int.self, forKey: .dueOn).toDate }
		catch { dueOn = nil }
		do    { completedOn = try values.decode(Int.self, forKey: .completedOn).toDate }
		catch { completedOn = nil }
		
		do    { isStarted = try values.decode(Bool.self, forKey: .isStarted) }
		catch { isStarted = false }
		do    { isCompleted = try values.decode(Bool.self, forKey: .isCompleted) }
		catch { isCompleted = false }
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestPlan : Codable
{
	let id:Int?
	let name:String?
	let description:String?
	let startOn:String?
	let startedOn:Int?
	let isStarted:Bool?
	let dueOn:Int?
	let isCompleted:Bool?
	let completedOn:Int?
	let projectID:Int?
	let parentID:String?
	let url:String?
	
	enum CodingKeys: String, CodingKey
	{
		case id          = "id"
		case name        = "name"
		case description = "description"
		case startOn     = "start_on"
		case startedOn   = "started_on"
		case isStarted   = "is_started"
		case dueOn       = "due_on"
		case isCompleted = "is_completed"
		case completedOn = "completed_on"
		case projectID   = "project_id"
		case parentID    = "parent_id"
		case url         = "url"
	}
	
	init(from decoder:Decoder) throws
	{
		let values  = try decoder.container(keyedBy: CodingKeys.self)
		id          = try values.decodeIfPresent(Int.self,    forKey: .id)
		name        = try values.decodeIfPresent(String.self, forKey: .name)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		startOn     = try values.decodeIfPresent(String.self, forKey: .startOn)
		startedOn   = try values.decodeIfPresent(Int.self,    forKey: .startedOn)
		isStarted   = try values.decodeIfPresent(Bool.self,   forKey: .isStarted)
		dueOn       = try values.decodeIfPresent(Int.self,    forKey: .dueOn)
		isCompleted = try values.decodeIfPresent(Bool.self,   forKey: .isCompleted)
		completedOn = try values.decodeIfPresent(Int.self,    forKey: .completedOn)
		projectID   = try values.decodeIfPresent(Int.self,    forKey: .projectID)
		parentID    = try values.decodeIfPresent(String.self, forKey: .parentID)
		url         = try values.decodeIfPresent(String.self, forKey: .url)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestRun : Codable
{
	let id:Int?
	let suiteID:Int?
	let name:String?
	let description:String?
	let milestoneID:Int?
	let assignedToID:Int?
	let includeAll:Bool?
	let isCompleted:Bool?
	let completedOn:String?
	let config:String?
	let configIDs:[String]?
	let passedCount:Int?
	let blockedCount:Int?
	let untestedCount:Int?
	let retestCount:Int?
	let failedCount:Int?
	let customStatus1Count:Int?
	let customStatus2Count:Int?
	let customStatus3Count:Int?
	let customStatus4Count:Int?
	let customStatus5Count:Int?
	let customStatus6Count:Int?
	let customStatus7Count:Int?
	let projectID:Int?
	let planID:String?
	let createdOn:Int?
	let createdBy:Int?
	let url:String?
	
	enum CodingKeys : String, CodingKey
	{
		case id                 = "id"
		case suiteID            = "suite_id"
		case name               = "name"
		case description        = "description"
		case milestoneID        = "milestone_id"
		case assignedToID       = "assignedto_id"
		case includeAll         = "include_all"
		case isCompleted        = "is_completed"
		case completedOn        = "completed_on"
		case config             = "config"
		case configIDs          = "config_ids"
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
		case projectID          = "project_id"
		case planID             = "plan_id"
		case createdOn          = "created_on"
		case createdBy          = "created_by"
		case url                = "url"
	}
	
	init(from decoder:Decoder) throws
	{
		let values         = try decoder.container(keyedBy: CodingKeys.self)
		id                 = try values.decodeIfPresent(Int.self,      forKey: .id)
		suiteID            = try values.decodeIfPresent(Int.self,      forKey: .suiteID)
		name               = try values.decodeIfPresent(String.self,   forKey: .name)
		description        = try values.decodeIfPresent(String.self,   forKey: .description)
		milestoneID        = try values.decodeIfPresent(Int.self,      forKey: .milestoneID)
		assignedToID       = try values.decodeIfPresent(Int.self,      forKey: .assignedToID)
		includeAll         = try values.decodeIfPresent(Bool.self,     forKey: .includeAll)
		isCompleted        = try values.decodeIfPresent(Bool.self,     forKey: .isCompleted)
		completedOn        = try values.decodeIfPresent(String.self,   forKey: .completedOn)
		config             = try values.decodeIfPresent(String.self,   forKey: .config)
		configIDs          = try values.decodeIfPresent([String].self, forKey: .configIDs)
		passedCount        = try values.decodeIfPresent(Int.self,      forKey: .passedCount)
		blockedCount       = try values.decodeIfPresent(Int.self,      forKey: .blockedCount)
		untestedCount      = try values.decodeIfPresent(Int.self,      forKey: .untestedCount)
		retestCount        = try values.decodeIfPresent(Int.self,      forKey: .retestCount)
		failedCount        = try values.decodeIfPresent(Int.self,      forKey: .failedCount)
		customStatus1Count = try values.decodeIfPresent(Int.self,      forKey: .customStatus1Count)
		customStatus2Count = try values.decodeIfPresent(Int.self,      forKey: .customStatus2Count)
		customStatus3Count = try values.decodeIfPresent(Int.self,      forKey: .customStatus3Count)
		customStatus4Count = try values.decodeIfPresent(Int.self,      forKey: .customStatus4Count)
		customStatus5Count = try values.decodeIfPresent(Int.self,      forKey: .customStatus5Count)
		customStatus6Count = try values.decodeIfPresent(Int.self,      forKey: .customStatus6Count)
		customStatus7Count = try values.decodeIfPresent(Int.self,      forKey: .customStatus7Count)
		projectID          = try values.decodeIfPresent(Int.self,      forKey: .projectID)
		planID             = try values.decodeIfPresent(String.self,   forKey: .planID)
		createdOn          = try values.decodeIfPresent(Int.self,      forKey: .createdOn)
		createdBy          = try values.decodeIfPresent(Int.self,      forKey: .createdBy)
		url                = try values.decodeIfPresent(String.self,   forKey: .url)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestCase : Codable
{
	let id:Int?
	let title:String?
	let sectionID:Int?
	let templateID:Int?
	let typeID:Int?
	let priorityID:Int?
	let milestoneID:String?
	let refs:String?
	let createdBy:Int?
	let createdOn:Int?
	let updatedBy:Int?
	let updatedOn:Int?
	let estimate:String?
	let estimateForecast:String?
	let suiteID:Int?
	let customAutomated:Int?
	let customPreconds:String?
	let customSteps:String?
	let customExpected:String?
	let customStepsSeparated:[TestRailTestCaseCustom]?
	let customMission:String?
	let customGoals:String?
	let customLabel:[String]?
	let customOS:[Int]?
	
	enum CodingKeys : String, CodingKey
	{
		case id                   = "id"
		case title                = "title"
		case sectionID            = "section_id"
		case templateID           = "template_id"
		case typeID               = "type_id"
		case priorityID           = "priority_id"
		case milestoneID          = "milestone_id"
		case refs                 = "refs"
		case createdBy            = "created_by"
		case createdOn            = "created_on"
		case updatedBy            = "updated_by"
		case updatedOn            = "updated_on"
		case estimate             = "estimate"
		case estimateForecast     = "estimate_forecast"
		case suiteID              = "suite_id"
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
	
	init(from decoder:Decoder) throws
	{
		let values           = try decoder.container(keyedBy: CodingKeys.self)
		id                   = try values.decodeIfPresent(Int.self,                      forKey: .id)
		title                = try values.decodeIfPresent(String.self,                   forKey: .title)
		sectionID            = try values.decodeIfPresent(Int.self,                      forKey: .sectionID)
		templateID           = try values.decodeIfPresent(Int.self,                      forKey: .templateID)
		typeID               = try values.decodeIfPresent(Int.self,                      forKey: .typeID)
		priorityID           = try values.decodeIfPresent(Int.self,                      forKey: .priorityID)
		milestoneID          = try values.decodeIfPresent(String.self,                   forKey: .milestoneID)
		refs                 = try values.decodeIfPresent(String.self,                   forKey: .refs)
		createdBy            = try values.decodeIfPresent(Int.self,                      forKey: .createdBy)
		createdOn            = try values.decodeIfPresent(Int.self,                      forKey: .createdOn)
		updatedBy            = try values.decodeIfPresent(Int.self,                      forKey: .updatedBy)
		updatedOn            = try values.decodeIfPresent(Int.self,                      forKey: .updatedOn)
		estimate             = try values.decodeIfPresent(String.self,                   forKey: .estimate)
		estimateForecast     = try values.decodeIfPresent(String.self,                   forKey: .estimateForecast)
		suiteID              = try values.decodeIfPresent(Int.self,                      forKey: .suiteID)
		customAutomated      = try values.decodeIfPresent(Int.self,                      forKey: .customAutomated)
		customPreconds       = try values.decodeIfPresent(String.self,                   forKey: .customPreconds)
		customSteps          = try values.decodeIfPresent(String.self,                   forKey: .customSteps)
		customExpected       = try values.decodeIfPresent(String.self,                   forKey: .customExpected)
		customStepsSeparated = try values.decodeIfPresent([TestRailTestCaseCustom].self, forKey: .customStepsSeparated)
		customMission        = try values.decodeIfPresent(String.self,                   forKey: .customMission)
		customGoals          = try values.decodeIfPresent(String.self,                   forKey: .customGoals)
		customLabel          = try values.decodeIfPresent([String].self,                 forKey: .customLabel)
		customOS             = try values.decodeIfPresent([Int].self,                    forKey: .customOS)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestCaseCustom : Codable
{
	let content:String?
	let expected:String?
	
	enum CodingKeys: String, CodingKey
	{
		case content  = "content"
		case expected = "expected"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		content  = try values.decodeIfPresent(String.self, forKey: .content)
		expected = try values.decodeIfPresent(String.self, forKey: .expected)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailStatus : Codable
{
	let id:Int?
	let name:String?
	let label:String?
	let colorDark:Int?
	let colorMedium:Int?
	let colorBright:Int?
	let isSystem:Bool?
	let isUntested:Bool?
	let isFinal:Bool?
	
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
		id          = try values.decodeIfPresent(Int.self,           forKey: .id)
		name        = try values.decodeIfPresent(String.self,        forKey: .name)
		label       = try values.decodeIfPresent(String.self,        forKey: .label)
		colorDark   = try values.decodeIfPresent(Int.self,           forKey: .colorDark)
		colorMedium = try values.decodeIfPresent(Int.self,           forKey: .colorMedium)
		colorBright = try values.decodeIfPresent(Int.self,           forKey: .colorBright)
		isSystem    = try values.decodeIfPresent(Bool.self,          forKey: .isSystem)
		isUntested  = try values.decodeIfPresent(Bool.self,          forKey: .isUntested)
		isFinal     = try values.decodeIfPresent(Bool.self,          forKey: .isFinal)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestCaseField : Codable
{
	let id:Int?
	let is_active:Bool?
	let type_id:Int?
	let name:String?
	let system_name:String?
	let label:String?
	let description:String?
	let configs:[TestRailConfig]?
	let display_order:Int?
	let include_all:Bool?
	let template_ids:[Int]?
	
	enum CodingKeys : String, CodingKey
	{
		case id = "id"
		case is_active = "is_active"
		case type_id = "type_id"
		case name = "name"
		case system_name = "system_name"
		case label = "label"
		case description = "description"
		case configs = "configs"
		case display_order = "display_order"
		case include_all = "include_all"
		case template_ids = "template_ids"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		is_active = try values.decodeIfPresent(Bool.self, forKey: .is_active)
		type_id = try values.decodeIfPresent(Int.self, forKey: .type_id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		system_name = try values.decodeIfPresent(String.self, forKey: .system_name)
		label = try values.decodeIfPresent(String.self, forKey: .label)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		configs = try values.decodeIfPresent([TestRailConfig].self, forKey: .configs)
		display_order = try values.decodeIfPresent(Int.self, forKey: .display_order)
		include_all = try values.decodeIfPresent(Bool.self, forKey: .include_all)
		template_ids = try values.decodeIfPresent([Int].self, forKey: .template_ids)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailConfig : Codable
{
	let context:TestRailContext?
	let options:TestRailOptions?
	let id:String?
	
	enum CodingKeys : String, CodingKey
	{
		case context
		case options
		case id = "id"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		context = try TestRailContext(from: decoder)
		options = try TestRailOptions(from: decoder)
		id = try values.decodeIfPresent(String.self, forKey: .id)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailContext: Codable
{
	let isGlobal:Bool?
	let projectIDs:String?
	
	enum CodingKeys : String, CodingKey
	{
		case isGlobal   = "is_global"
		case projectIDs = "project_ids"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		isGlobal   = try values.decodeIfPresent(Bool.self,   forKey: .isGlobal)
		projectIDs = try values.decodeIfPresent(String.self, forKey: .projectIDs)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailOptions: Codable
{
	let isRequired:Bool?
	let defaultValue:String?
	let format:String?
	let rows:Int?
	
	enum CodingKeys : String, CodingKey
	{
		case isRequired   = "is_required"
		case defaultValue = "default_value"
		case format       = "format"
		case rows         = "rows"
	}
	
	init(from decoder:Decoder) throws
	{
		let values   = try decoder.container(keyedBy: CodingKeys.self)
		isRequired   = try values.decodeIfPresent(Bool.self,   forKey: .isRequired)
		defaultValue = try values.decodeIfPresent(String.self, forKey: .defaultValue)
		format       = try values.decodeIfPresent(String.self, forKey: .format)
		rows         = try values.decodeIfPresent(Int.self,    forKey: .rows)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailType : Codable
{
	let id:Int?
	let name:String?
	let isDefault:Bool?
	
	enum CodingKeys : String, CodingKey
	{
		case id        = "id"
		case name      = "name"
		case isDefault = "is_default"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id        = try values.decodeIfPresent(Int.self,    forKey: .id)
		name      = try values.decodeIfPresent(String.self, forKey: .name)
		isDefault = try values.decodeIfPresent(Bool.self,   forKey: .isDefault)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailPriority : Codable
{
	let id:Int?
	let name:String?
	let shortName:String?
	let isDefault:Bool?
	let priority:Int?
	
	enum CodingKeys : String, CodingKey
	{
		case id        = "id"
		case name      = "name"
		case shortName = "short_name"
		case isDefault = "is_default"
		case priority  = "priority"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id        = try values.decodeIfPresent(Int.self,    forKey: .id)
		name      = try values.decodeIfPresent(String.self, forKey: .name)
		shortName = try values.decodeIfPresent(String.self, forKey: .shortName)
		isDefault = try values.decodeIfPresent(Bool.self,   forKey: .isDefault)
		priority  = try values.decodeIfPresent(Int.self,    forKey: .priority)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTest : Codable
{
	let id:Int?
	let caseID:Int?
	let statusID:Int?
	let assignedToID:Int?
	let runID:Int?
	let title:String?
	let templateID:Int?
	let typeID:Int?
	let priorityID:Int?
	let estimate:String?
	let estimateForecast:String?
	let refs:String?
	let milestoneID:String?
	let customAutomated:String?
	let customPreconds:String?
	let customSteps:String?
	let customExpected:String?
	let customStepsSeparated:[TestRailCustomTestStep]?
	let customMission:String?
	let customGoals:String?
	let customLabel:[String]?
	let customOS:[Int]?
	
	enum CodingKeys : String, CodingKey
	{
		case id                   = "id"
		case caseID               = "case_id"
		case statusID             = "status_id"
		case assignedToID         = "assignedto_id"
		case runID                = "run_id"
		case title                = "title"
		case templateID           = "template_id"
		case typeID               = "type_id"
		case priorityID           = "priority_id"
		case estimate             = "estimate"
		case estimateForecast     = "estimate_forecast"
		case refs                 = "refs"
		case milestoneID          = "milestone_id"
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
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id                   = try values.decodeIfPresent(Int.self,                      forKey: .id)
		caseID               = try values.decodeIfPresent(Int.self,                      forKey: .caseID)
		statusID             = try values.decodeIfPresent(Int.self,                      forKey: .statusID)
		assignedToID         = try values.decodeIfPresent(Int.self,                      forKey: .assignedToID)
		runID                = try values.decodeIfPresent(Int.self,                      forKey: .runID)
		title                = try values.decodeIfPresent(String.self,                   forKey: .title)
		templateID           = try values.decodeIfPresent(Int.self,                      forKey: .templateID)
		typeID               = try values.decodeIfPresent(Int.self,                      forKey: .typeID)
		priorityID           = try values.decodeIfPresent(Int.self,                      forKey: .priorityID)
		estimate             = try values.decodeIfPresent(String.self,                   forKey: .estimate)
		estimateForecast     = try values.decodeIfPresent(String.self,                   forKey: .estimateForecast)
		refs                 = try values.decodeIfPresent(String.self,                   forKey: .refs)
		milestoneID          = try values.decodeIfPresent(String.self,                   forKey: .milestoneID)
		customAutomated      = try values.decodeIfPresent(String.self,                   forKey: .customAutomated)
		customPreconds       = try values.decodeIfPresent(String.self,                   forKey: .customPreconds)
		customSteps          = try values.decodeIfPresent(String.self,                   forKey: .customSteps)
		customExpected       = try values.decodeIfPresent(String.self,                   forKey: .customExpected)
		customStepsSeparated = try values.decodeIfPresent([TestRailCustomTestStep].self, forKey: .customStepsSeparated)
		customMission        = try values.decodeIfPresent(String.self,                   forKey: .customMission)
		customGoals          = try values.decodeIfPresent(String.self,                   forKey: .customGoals)
		customLabel          = try values.decodeIfPresent([String].self,                 forKey: .customLabel)
		customOS             = try values.decodeIfPresent([Int].self,                    forKey: .customOS)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailCustomTestStep : Codable
{
	let content:String?
	let expected:String?
	
	enum CodingKeys : String, CodingKey
	{
		case content  = "content"
		case expected = "expected"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		content  = try values.decodeIfPresent(String.self, forKey: .content)
		expected = try values.decodeIfPresent(String.self, forKey: .expected)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestResult : Codable
{
	let id:Int?
	let testID:Int?
	let statusID:Int?
	let createdBy:Int?
	let createdOn:Int?
	let assignedToID:Int?
	let comment:String?
	let version:String?
	let elapsed:String?
	let defects:String?
	let customStepResults:[TestRailCustomTestStepResult]?
	
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
		id                = try values.decodeIfPresent(Int.self,                            forKey: .id)
		testID            = try values.decodeIfPresent(Int.self,                            forKey: .testID)
		statusID          = try values.decodeIfPresent(Int.self,                            forKey: .statusID)
		createdBy         = try values.decodeIfPresent(Int.self,                            forKey: .createdBy)
		createdOn         = try values.decodeIfPresent(Int.self,                            forKey: .createdOn)
		assignedToID      = try values.decodeIfPresent(Int.self,                            forKey: .assignedToID)
		comment           = try values.decodeIfPresent(String.self,                         forKey: .comment)
		version           = try values.decodeIfPresent(String.self,                         forKey: .version)
		elapsed           = try values.decodeIfPresent(String.self,                         forKey: .elapsed)
		defects           = try values.decodeIfPresent(String.self,                         forKey: .defects)
		customStepResults = try values.decodeIfPresent([TestRailCustomTestStepResult].self, forKey: .customStepResults)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailCustomTestStepResult : Codable
{
	let content:String?
	let expected:String?
	let actual:String?
	let statusID:Int?
	
	enum CodingKeys : String, CodingKey
	{
		case content  = "content"
		case expected = "expected"
		case actual   = "actual"
		case statusID = "status_id"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		content  = try values.decodeIfPresent(String.self, forKey: .content)
		expected = try values.decodeIfPresent(String.self, forKey: .expected)
		actual   = try values.decodeIfPresent(String.self, forKey: .actual)
		statusID = try values.decodeIfPresent(Int.self,    forKey: .statusID)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestResultField : Codable
{
	let id:Int?
	let isActive:Bool?
	let typeID:Int?
	let name:String?
	let systemName:String?
	let label:String?
	let description:String?
	let configs:[TestRailConfig]?
	let displayOrder:Int?
	let includeAll:Bool?
	let templateIDs:[Int]?
	
	enum CodingKeys : String, CodingKey
	{
		case id           = "id"
		case isActive     = "is_active"
		case typeID       = "type_id"
		case name         = "name"
		case systemName   = "system_name"
		case label        = "label"
		case description  = "description"
		case configs      = "configs"
		case displayOrder = "display_order"
		case includeAll   = "include_all"
		case templateIDs  = "template_ids"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id           = try values.decodeIfPresent(Int.self,              forKey: .id)
		isActive     = try values.decodeIfPresent(Bool.self,             forKey: .isActive)
		typeID       = try values.decodeIfPresent(Int.self,              forKey: .typeID)
		name         = try values.decodeIfPresent(String.self,           forKey: .name)
		systemName   = try values.decodeIfPresent(String.self,           forKey: .systemName)
		label        = try values.decodeIfPresent(String.self,           forKey: .label)
		description  = try values.decodeIfPresent(String.self,           forKey: .description)
		configs      = try values.decodeIfPresent([TestRailConfig].self, forKey: .configs)
		displayOrder = try values.decodeIfPresent(Int.self,              forKey: .displayOrder)
		includeAll   = try values.decodeIfPresent(Bool.self,             forKey: .includeAll)
		templateIDs  = try values.decodeIfPresent([Int].self,            forKey: .templateIDs)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailSection : Codable
{
	let id:Int?
	let suiteID:Int?
	let name:String?
	let description:String?
	let parentID:String?
	let displayOrder:Int?
	let depth:Int?
	
	enum CodingKeys : String, CodingKey
	{
		case id           = "id"
		case suiteID      = "suite_id"
		case name         = "name"
		case description  = "description"
		case parentID     = "parent_id"
		case displayOrder = "display_order"
		case depth        = "depth"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id           = try values.decodeIfPresent(Int.self,    forKey: .id)
		suiteID      = try values.decodeIfPresent(Int.self,    forKey: .suiteID)
		name         = try values.decodeIfPresent(String.self, forKey: .name)
		description  = try values.decodeIfPresent(String.self, forKey: .description)
		parentID     = try values.decodeIfPresent(String.self, forKey: .parentID)
		displayOrder = try values.decodeIfPresent(Int.self,    forKey: .displayOrder)
		depth        = try values.decodeIfPresent(Int.self,    forKey: .depth)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTemplate : Codable
{
	let id:Int?
	let name:String?
	let isDefault:Bool?
	
	enum CodingKeys : String, CodingKey
	{
		case id        = "id"
		case name      = "name"
		case isDefault = "is_default"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id        = try values.decodeIfPresent(Int.self,    forKey: .id)
		name      = try values.decodeIfPresent(String.self, forKey: .name)
		isDefault = try values.decodeIfPresent(Bool.self,   forKey: .isDefault)
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailUser : Codable
{
	let id:Int?
	let name:String?
	let email:String?
	let isActive:Bool?
	
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
		id       = try values.decodeIfPresent(Int.self,    forKey: .id)
		name     = try values.decodeIfPresent(String.self, forKey: .name)
		email    = try values.decodeIfPresent(String.self, forKey: .email)
		isActive = try values.decodeIfPresent(Bool.self,   forKey: .isActive)
	}
}
