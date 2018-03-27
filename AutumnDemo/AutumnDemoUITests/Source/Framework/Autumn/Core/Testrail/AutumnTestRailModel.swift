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
	var masterSuiteID = 0
	
	var projects   = [TestRailProject]()
	var suites     = [TestRailSuite]()
	var milestones = [TestRailMilestone]()
	var testPlans  = [TestRailTestPlan]()
	var testRuns   = [TestRailTestRun]()
	var testCases  = [TestRailTestCase]()
	var statuses   = [TestRailStatus]()
}


// ------------------------------------------------------------------------------------------------
struct TestRailProject : Codable
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
}


// ------------------------------------------------------------------------------------------------
struct TestRailSuite : Codable
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
}


// ------------------------------------------------------------------------------------------------
struct TestRailMilestone : Codable
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
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestPlan : Codable
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
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestRun : Codable
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
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestCase : Codable
{
	let id:Int
	let suiteID:Int
	let milestoneID:Int
	let sectionID:Int
	let templateID:Int
	let typeID:Int
	let priorityID:Int
	let createdBy:Int
	let updatedBy:Int
	let title:String
	let refs:String
	let estimate:String
	let estimateForecast:String
	let createdOn:Date?
	let updatedOn:Date?
	
	let customAutomated:Int
	let customPreconds:String
	let customSteps:[String]
	let customExpected:String
	let customStepsSeparated:[TestRailTestCaseCustom]
	let customMission:String
	let customGoals:String
	let customLabel:[String]
	let customOS:[Int]
	
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
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id                   = try values.decode(Int.self,                      forKey: .id) }                   catch { id = 0 }
		do { suiteID              = try values.decode(Int.self,                      forKey: .suiteID) }              catch { suiteID = 0 }
		do { milestoneID          = try values.decode(Int.self,                      forKey: .milestoneID) }          catch { milestoneID = 0 }
		do { sectionID            = try values.decode(Int.self,                      forKey: .sectionID) }            catch { sectionID = 0 }
		do { templateID           = try values.decode(Int.self,                      forKey: .templateID) }           catch { templateID = 0 }
		do { typeID               = try values.decode(Int.self,                      forKey: .typeID) }               catch { typeID = 0 }
		do { priorityID           = try values.decode(Int.self,                      forKey: .priorityID) }           catch { priorityID = 0 }
		do { createdBy            = try values.decode(Int.self,                      forKey: .createdBy) }            catch { createdBy = 0 }
		do { updatedBy            = try values.decode(Int.self,                      forKey: .updatedBy) }            catch { updatedBy = 0 }
		do { title                = try values.decode(String.self,                   forKey: .title) }                catch { title = "" }
		do { refs                 = try values.decode(String.self,                   forKey: .refs) }                 catch { refs = "" }
		do { estimate             = try values.decode(String.self,                   forKey: .estimate) }             catch { estimate = "" }
		do { estimateForecast     = try values.decode(String.self,                   forKey: .estimateForecast) }     catch { estimateForecast = "" }
		do { createdOn            = try values.decode(Int.self,                      forKey: .createdOn).toDate }     catch { createdOn = nil }
		do { updatedOn            = try values.decode(Int.self,                      forKey: .updatedOn).toDate }     catch { updatedOn = nil }
		do { customAutomated      = try values.decode(Int.self,                      forKey: .customAutomated) }      catch { customAutomated = 0 }
		do { customPreconds       = try values.decode(String.self,                   forKey: .customPreconds) }       catch { customPreconds = "" }
		do { customSteps          = try values.decode([String].self,                 forKey: .customSteps) }          catch { customSteps = [String]() }
		do { customExpected       = try values.decode(String.self,                   forKey: .customExpected) }       catch { customExpected = "" }
		do { customStepsSeparated = try values.decode([TestRailTestCaseCustom].self, forKey: .customStepsSeparated) } catch { customStepsSeparated = [TestRailTestCaseCustom]() }
		do { customMission        = try values.decode(String.self,                   forKey: .customMission) }        catch { customMission = "" }
		do { customGoals          = try values.decode(String.self,                   forKey: .customGoals) }          catch { customGoals = "" }
		do { customLabel          = try values.decode([String].self,                 forKey: .customLabel) }          catch { customLabel = [String]() }
		do { customOS             = try values.decode([Int].self,                    forKey: .customOS) }             catch { customOS = [Int]() }
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestCaseCustom : Codable
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
}


// ------------------------------------------------------------------------------------------------
struct TestRailStatus : Codable
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
		id = try values.decode(Int.self, forKey: .id)
		is_active = try values.decode(Bool.self, forKey: .is_active)
		type_id = try values.decode(Int.self, forKey: .type_id)
		name = try values.decode(String.self, forKey: .name)
		system_name = try values.decode(String.self, forKey: .system_name)
		label = try values.decode(String.self, forKey: .label)
		description = try values.decode(String.self, forKey: .description)
		configs = try values.decode([TestRailConfig].self, forKey: .configs)
		display_order = try values.decode(Int.self, forKey: .display_order)
		include_all = try values.decode(Bool.self, forKey: .include_all)
		template_ids = try values.decode([Int].self, forKey: .template_ids)
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
		id = try values.decode(String.self, forKey: .id)
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
		isGlobal   = try values.decode(Bool.self,   forKey: .isGlobal)
		projectIDs = try values.decode(String.self, forKey: .projectIDs)
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
		isRequired   = try values.decode(Bool.self,   forKey: .isRequired)
		defaultValue = try values.decode(String.self, forKey: .defaultValue)
		format       = try values.decode(String.self, forKey: .format)
		rows         = try values.decode(Int.self,    forKey: .rows)
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
		id        = try values.decode(Int.self,    forKey: .id)
		name      = try values.decode(String.self, forKey: .name)
		isDefault = try values.decode(Bool.self,   forKey: .isDefault)
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
		id        = try values.decode(Int.self,    forKey: .id)
		name      = try values.decode(String.self, forKey: .name)
		shortName = try values.decode(String.self, forKey: .shortName)
		isDefault = try values.decode(Bool.self,   forKey: .isDefault)
		priority  = try values.decode(Int.self,    forKey: .priority)
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
		id                   = try values.decode(Int.self,                      forKey: .id)
		caseID               = try values.decode(Int.self,                      forKey: .caseID)
		statusID             = try values.decode(Int.self,                      forKey: .statusID)
		assignedToID         = try values.decode(Int.self,                      forKey: .assignedToID)
		runID                = try values.decode(Int.self,                      forKey: .runID)
		title                = try values.decode(String.self,                   forKey: .title)
		templateID           = try values.decode(Int.self,                      forKey: .templateID)
		typeID               = try values.decode(Int.self,                      forKey: .typeID)
		priorityID           = try values.decode(Int.self,                      forKey: .priorityID)
		estimate             = try values.decode(String.self,                   forKey: .estimate)
		estimateForecast     = try values.decode(String.self,                   forKey: .estimateForecast)
		refs                 = try values.decode(String.self,                   forKey: .refs)
		milestoneID          = try values.decode(String.self,                   forKey: .milestoneID)
		customAutomated      = try values.decode(String.self,                   forKey: .customAutomated)
		customPreconds       = try values.decode(String.self,                   forKey: .customPreconds)
		customSteps          = try values.decode(String.self,                   forKey: .customSteps)
		customExpected       = try values.decode(String.self,                   forKey: .customExpected)
		customStepsSeparated = try values.decode([TestRailCustomTestStep].self, forKey: .customStepsSeparated)
		customMission        = try values.decode(String.self,                   forKey: .customMission)
		customGoals          = try values.decode(String.self,                   forKey: .customGoals)
		customLabel          = try values.decode([String].self,                 forKey: .customLabel)
		customOS             = try values.decode([Int].self,                    forKey: .customOS)
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
		content  = try values.decode(String.self, forKey: .content)
		expected = try values.decode(String.self, forKey: .expected)
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
		id                = try values.decode(Int.self,                            forKey: .id)
		testID            = try values.decode(Int.self,                            forKey: .testID)
		statusID          = try values.decode(Int.self,                            forKey: .statusID)
		createdBy         = try values.decode(Int.self,                            forKey: .createdBy)
		createdOn         = try values.decode(Int.self,                            forKey: .createdOn)
		assignedToID      = try values.decode(Int.self,                            forKey: .assignedToID)
		comment           = try values.decode(String.self,                         forKey: .comment)
		version           = try values.decode(String.self,                         forKey: .version)
		elapsed           = try values.decode(String.self,                         forKey: .elapsed)
		defects           = try values.decode(String.self,                         forKey: .defects)
		customStepResults = try values.decode([TestRailCustomTestStepResult].self, forKey: .customStepResults)
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
		content  = try values.decode(String.self, forKey: .content)
		expected = try values.decode(String.self, forKey: .expected)
		actual   = try values.decode(String.self, forKey: .actual)
		statusID = try values.decode(Int.self,    forKey: .statusID)
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
		id           = try values.decode(Int.self,              forKey: .id)
		isActive     = try values.decode(Bool.self,             forKey: .isActive)
		typeID       = try values.decode(Int.self,              forKey: .typeID)
		name         = try values.decode(String.self,           forKey: .name)
		systemName   = try values.decode(String.self,           forKey: .systemName)
		label        = try values.decode(String.self,           forKey: .label)
		description  = try values.decode(String.self,           forKey: .description)
		configs      = try values.decode([TestRailConfig].self, forKey: .configs)
		displayOrder = try values.decode(Int.self,              forKey: .displayOrder)
		includeAll   = try values.decode(Bool.self,             forKey: .includeAll)
		templateIDs  = try values.decode([Int].self,            forKey: .templateIDs)
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
		id           = try values.decode(Int.self,    forKey: .id)
		suiteID      = try values.decode(Int.self,    forKey: .suiteID)
		name         = try values.decode(String.self, forKey: .name)
		description  = try values.decode(String.self, forKey: .description)
		parentID     = try values.decode(String.self, forKey: .parentID)
		displayOrder = try values.decode(Int.self,    forKey: .displayOrder)
		depth        = try values.decode(Int.self,    forKey: .depth)
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
		id        = try values.decode(Int.self,    forKey: .id)
		name      = try values.decode(String.self, forKey: .name)
		isDefault = try values.decode(Bool.self,   forKey: .isDefault)
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
		id       = try values.decode(Int.self,    forKey: .id)
		name     = try values.decode(String.self, forKey: .name)
		email    = try values.decode(String.self, forKey: .email)
		isActive = try values.decode(Bool.self,   forKey: .isActive)
	}
}
