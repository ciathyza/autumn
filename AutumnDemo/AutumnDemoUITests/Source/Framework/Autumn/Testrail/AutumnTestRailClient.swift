//
// AutumnTestRailClient.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/22.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation
import Alamofire


class AutumnTestRailClient
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let config:AutumnConfig
	let model:AutumnModel
	
	private var _isTestRailRetrievalComplete = false
	private var _isTestRailSubmissionComplete = false
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Derived Properties
	// ----------------------------------------------------------------------------------------------------
	
	var isTestRailSubmissionComplete:Bool { return _isTestRailSubmissionComplete }
	
	var authString:String
	{
		return "\(config.testrailUserEmail)" + ":\(config.testrailPassword)"
	}
	var authData:Data? { return authString.data(using: .ascii) }
	let dispatchQueue = DispatchQueue(label: "com.autumn.manager-response-queue", qos: .userInitiated, attributes:.concurrent)
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(_ config:AutumnConfig, _ model:AutumnModel)
	{
		self.config = config
		self.model = model
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Public Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Non-Async method to retrieve all TestRail data.
	 */
	func retrieveTestRailData()
	{
		getTestRailProjects()
		getTestRailSuites()
		getTestRailUsers()
		getTestRailMilestones()
		getTestRailStatuses()
		getTestRailTestCaseFields()
		getTestRailTestCaseTypes()
		getTestRailTemplates()
		getTestRailTestPlans()
		getTestRailTestCaseSections()
		getTestRailTestRuns()
		getTestRailTests()
		getTestRailTestCases()
	}
	
	
	/**
	 * Syncs all required server data with the state of local data.
	 */
	func syncData()
	{
		syncRootSection()
		syncSections()
		syncFeatures()
		syncTestRun()
	}
	
	
	/**
	 * Submits a test case result to the TestRail server.
	 */
	func submitTestResult(_ scenario:AutumnScenario)
	{
		_isTestRailSubmissionComplete = false
		
		if let testCase = model.getTestRailCaseForScenario(scenario.id), let caseID = testCase.id
		{
			/* Determine result status ID from test result. */
			var statusID = AutumnTestRailResultStatusID.Pending
			if scenario.status == .Unsupported { statusID = .CannotTest }
			else if scenario.status == .Failed { statusID = .Failed }
			else if scenario.status == .Passed { statusID = .Passed }
			else { statusID = .Pending }
			
			/* Determine assigned-to user ID. */
			var userID = 0
			if let user = model.getTestRailUser(config.testrailUserEmail)
			{
				userID = user.id
			}
			
			/* Prepare detailed step results as comment string. */
			var comment:String? = nil
			if statusID == .CannotTest && scenario.unsupportedReason != .None
			{
				comment = "Unsupported reason: \(scenario.unsupportedReason.rawValue)"
			}
			else if statusID != .Pending
			{
				comment = "|||:Phase|:Type|:Name|:Result"
				for row in scenario.result.rows
				{
					comment = comment! + "\n|| \(row.phase) | \(row.type) | \(row.stepType != .None ? "\(row.stepType.rawValue) " : "")\(row.name) | \(row.result.rawValue) "
				}
			}
			
			/* Create new result for submission. */
			var result = TestRailTestResult()
			result.statusID = statusID.rawValue
			result.comment = comment
			result.version = Bundle.main.versionStringPretty
			result.elapsed = scenario.elapsed ?? ""
			result.defects = nil
			result.assignedToID = userID
			
			addTestCaseResult(testRunID: model.testrailTestRunID, caseID: caseID, testCaseResult: result)
			{
				(response:TestRailTestResult?, error:String?) in
				if let error = error { AutumnLog.error(error) }
				else { AutumnLog.debug("Submitted test result for test case ID \(caseID).") }
				self._isTestRailSubmissionComplete = true
			}
		}
		else
		{
			AutumnLog.error("No test case with ref \(scenario.id) found.")
		}
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Sync API
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Syncs the root section.
	 */
	private func syncRootSection()
	{
		_isTestRailRetrievalComplete = false
		AutumnLog.debug("Syncing root section used for automtion test cases ...")
		syncSection(config.testrailRootSectionName, config.testrailRootSectionDescription, nil)
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	/**
	 * Syncs all local features with remote sections.
	 *
	 * - Marks as orphaned all sections from TestRail under automation root section for which it cannot find a
	 *   local feature with the same name.
	 *
	 * - Updates the names of any remaining sections for which there is a local feature with the
	 *   same description.
	 */
	private func syncSections()
	{
		if let rootSectionID = model.testRailRootSection?.id
		{
			_isTestRailRetrievalComplete = false
			AutumnLog.debug("Syncing all child sections ...")
			let features = model.features
			for feature in features
			{
				syncSection(feature.name, feature.descr, rootSectionID)
			}
			AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
			
			if model.testrailOrphanedSections.count > 0
			{
				AutumnLog.debug("Found \(model.testrailOrphanedSections.count) orphaned sections.\(self.config.debug ? ("\(self.dump(model.testrailOrphanedSections))") : "")")
			}
		}
	}
	
	
	/**
	 * Syncs a TestRail section.
	 * If the section with the same name already exists on TestRail it will be re-used.
	 */
	private func syncSection(_ sectionName:String, _ description:String?, _ parentID:Int?)
	{
		_isTestRailRetrievalComplete = false
		/* Model already contains the section which means it was created earlier. */
		if let section = model.getTestRailSection(sectionName)
		{
			/* Does the model still contain a feature for the section? */
			if section.isRoot()
			{
				model.testRailRootSection = section
				AutumnLog.debug("Found root section: \"\(section.name)\".")
			}
			else if model.hasFeatureWithName(section.name)
			{
				AutumnLog.debug("Found existing \"\(section.name)\" section.")
			}
			else
			{
				model.testrailOrphanedSections.append(section)
			}
			_isTestRailRetrievalComplete = true
		}
		else
		{
			/* Create new section to work with! */
			let section = TestRailSection(name: sectionName, description: description, parentID: parentID)
			createNewSection(section: section, projectID: config.testrailProjectID)
			{
				(response:TestRailSection?, error:String?) in
				if let error = error { AutumnLog.error(error) }
				if let r = response
				{
					self.model.addTestRailSection(r)
					if r.isRoot()
					{
						self.model.testRailRootSection = r
						AutumnLog.debug("Created new root section: \"\(sectionName)\"")
					}
					else
					{
						AutumnLog.debug("Created new \"\(sectionName)\" section.")
					}
				}
				self._isTestRailRetrievalComplete = true
			}
		}
	}
	
	
	private func syncFeatures()
	{
		_isTestRailRetrievalComplete = false
		AutumnLog.debug("Syncing all features and their test cases ...")
		for feature in model.features
		{
			syncFeature(feature)
		}
	}
	
	
	/**
	 * Creates a TestRail feature with all included scenarios and submits it to TestRail as a test case.
	 * If the test case already exists on TestRail it will be updated.
	 */
	private func syncFeature(_ feature:AutumnFeature)
	{
		if model.testRailRootSection != nil
		{
			AutumnLog.debug("Syncing TestRail feature for \"\(feature.name)\" ...")
			_isTestRailRetrievalComplete = false
			
			if let section = model.getTestRailSection(feature.name)
			{
				let scenarios = feature.getScenarios()
				for scenario in scenarios
				{
					scenario.setup()
					scenario.resetNameRecords()
					
					if model.getTestRailCase(scenario.title) != nil
					{
						/* A test case with the same name already exists. */
					}
					else
					{
						/* Create new test case from local scenario. */
						var testCase = TestRailTestCase(model.testrailMasterSuiteID, section.id, scenario.title)
						testCase.templateID = model.getTestRailCaseTemplateIDFor(template: config.testrailTemplate)
						testCase.typeID = model.getTestRailCaseTypeIDFor(type: config.testrailTestType)
						testCase.priorityID = scenario.priority.rawValue
						testCase.estimate = scenario.estimate
						testCase.refs = "\(scenario.id)"
						testCase.customOS = [Int]()
						testCase.customOS!.append(config.testrailOSIDs[AutumnPlatform.iOS.rawValue]!)
						testCase.customPreconds = ""
						testCase.customStepsSeparated = [TestRailTestCaseCustom]()
						
						/* Record precondition steps. */
						scenario.establish()
						var index = 0
						for n in scenario.preconditionStrings
						{
							testCase.customPreconds! += "\(n)"
							if index < scenario.preconditionStrings.count - 1 { testCase.customPreconds! += "\n" }
							index += 1
						}
						
						/* Record execution steps. */
						scenario.execute()
						var executionStepsBatch = ""
						index = 0
						for n in scenario.executionStrings
						{
							if n.starts(with: AutumnStepType.When.rawValue)
							{
								executionStepsBatch += "\(n)"
								if index < scenario.executionStrings.count - 1 { executionStepsBatch += "\n" }
								index += 1
							}
							else if n.starts(with: AutumnStepType.Then.rawValue)
							{
								let customTestStep = TestRailTestCaseCustom(content: executionStepsBatch, expected: n)
								testCase.customStepsSeparated!.append(customTestStep)
								executionStepsBatch = ""
							}
						}
						
						syncTestCase(testCase, sectionID: section.id)
						AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
					}
				}
			}
		}
		else
		{
			AutumnLog.error("No TestRail root section was found!")
		}
	}
	
	
	/**
	 * Syncs a TestRail test case.
	 * If the case with the same name already exists on TestRail and the data differs, it will be updated
	 * with the local test case.
	 */
	private func syncTestCase(_ testCase:TestRailTestCase, sectionID:Int)
	{
		_isTestRailRetrievalComplete = false
		/* Check if a test case with same title and an ID already exists. */
		if let tc = model.getTestRailCase(testCase.title), let testCaseID = tc.id
		{
			/* Check if the two test cases are identical (except for the ID because the ID of a
			   newly created test case is still nil. */
			if testCase.title == tc.title
			{
				/* New and existing test case with same title are identical! No need to update. */
				self._isTestRailRetrievalComplete = true
			}
			else
			{
				/* Update existing test case. */
				updateTestCase(testCase: testCase, caseID: testCaseID)
				{
					(response:TestRailTestCase?, error:String?) in
					if let error = error { AutumnLog.error(error) }
					if let r = response
					{
						if self.model.replaceTestRailCase(r)
						{
							AutumnLog.debug("Updated existing test case: \"\(tc.title)\" (ID: \(testCaseID)).")
						}
						else
						{
							AutumnLog.warning("Failed to replace test case with ID \(testCaseID).")
						}
					}
					self._isTestRailRetrievalComplete = true
				}
			}
		}
		else
		{
			/* Create new test case to work with! */
			createNewTestCase(testCase: testCase, sectionID: sectionID)
			{
				(response:TestRailTestCase?, error:String?) in
				if let error = error { AutumnLog.error(error) }
				if let r = response
				{
					self.model.addTestRailCase(r)
				}
				AutumnLog.debug("Created new test case with title \"\(testCase.title)\" and ID \(String(describing: testCase.id)).")
				self._isTestRailRetrievalComplete = true
			}
		}
	}
	
	
	private func syncTestRun()
	{
		_isTestRailRetrievalComplete = false
		AutumnLog.debug("Syncing automation test run ...")
		
		if var testRun = model.getTestRailTestRun(config.testrailRootSectionName)
		{
			AutumnLog.debug("Found automation test run with name \(testRun.name).")
			self.model.testrailTestRunID = testRun.id
			
			/* Update test run with new cases that might have been addded. */
			testRun.caseIDs = [Int]()
			for testCase in model.testrailCases
			{
				if let id = testCase.id
				{
					testRun.caseIDs.append(id)
				}
			}
			
			updateTestRun(testRun: testRun)
			{
				(response:TestRailTestRun?, error:String?) in
				if let error = error { AutumnLog.error(error) }
				if let r = response
				{
					self.model.testrailTestRunID = r.id
					AutumnLog.debug("Updated automation test run with ID \(r.id).")
				}
				self._isTestRailRetrievalComplete = true
			}
		}
		else
		{
			/* Create new test run with all automation case IDs. */
			if let user = model.getTestRailUser(config.testrailUserEmail), let milestone = model.getTestRailMilestone(config.testrailMilestoneName)
			{
				var testRun = TestRailTestRun(model.testrailMasterSuiteID, config.testrailProjectID, milestone.id, config.testrailRootSectionName)
				testRun.assignedToID = user.id
				testRun.description = "Test run for automation test cases."
				testRun.includeAll = false
				testRun.caseIDs = [Int]()
				for testCase in model.testrailCases
				{
					if let id = testCase.id
					{
						testRun.caseIDs.append(id)
					}
				}
				
				createNewTestRun(testRun: testRun, projectID: config.testrailProjectID)
				{
					(response:TestRailTestRun?, error:String?) in
					if let error = error { AutumnLog.error(error) }
					if let r = response
					{
						self.model.testrailTestRunID = r.id
						AutumnLog.debug("Created automation test run with ID \(r.id).")
					}
					self._isTestRailRetrievalComplete = true
				}
			}
		}
	}
	
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Get API
	// ----------------------------------------------------------------------------------------------------
	
	func getStatuses(callback: @escaping (([TestRailStatus]?, _:String?) -> Void))
	{
		httpGet(path: "get_statuses", type: [TestRailStatus].self, callback: callback)
	}
	
	
	func getTestCaseFields(callback: @escaping (([TestRailTestCaseField]?, _:String?) -> Void))
	{
		httpGet(path: "get_case_fields", type: [TestRailTestCaseField].self, callback: callback)
	}
	
	
	func getTestCaseTypes(callback: @escaping (([TestRailTestCaseType]?, _:String?) -> Void))
	{
		httpGet(path: "get_case_types", type: [TestRailTestCaseType].self, callback: callback)
	}
	
	
	func getTemplates(projectID:Int, callback: @escaping (([TestRailTemplate]?, _:String?) -> Void))
	{
		httpGet(path: "get_templates/\(projectID)", type: [TestRailTemplate].self, callback: callback)
	}
	
	
	func getTestCaseSections(projectID:Int, suiteID:Int, callback: @escaping (([TestRailSection]?, _:String?) -> Void))
	{
		httpGet(path: "get_sections/\(projectID)&suite_id=\(suiteID)", type: [TestRailSection].self, callback: callback)
	}
	
	
	func getProjects(callback: @escaping (([TestRailProject]?, _:String?) -> Void))
	{
		httpGet(path: "get_projects", type: [TestRailProject].self, callback: callback)
	}
	
	
	func getSuites(projectID:Int, callback: @escaping (([TestRailSuite]?, _:String?) -> Void))
	{
		httpGet(path: "get_suites/\(projectID)", type: [TestRailSuite].self, callback: callback)
	}
	
	
	func getUsers(callback: @escaping (([TestRailUser]?, _:String?) -> Void))
	{
		httpGet(path: "get_users", type: [TestRailUser].self, callback: callback)
	}
	
	
	func getMilestones(projectID:Int, callback: @escaping (([TestRailMilestone]?, _:String?) -> Void))
	{
		httpGet(path: "get_milestones/\(projectID)", type: [TestRailMilestone].self, callback: callback)
	}
	
	
	func getTestPlans(projectID:Int, callback: @escaping (([TestRailTestPlan]?, _:String?) -> Void))
	{
		httpGet(path: "get_plans/\(projectID)", type: [TestRailTestPlan].self, callback: callback)
	}
	
	
	func getTestRuns(projectID:Int, callback: @escaping (([TestRailTestRun]?, _:String?) -> Void))
	{
		httpGet(path: "get_runs/\(projectID)", type: [TestRailTestRun].self, callback: callback)
	}
	
	
	func getTestCases(projectID:Int, suiteID:Int, sectionID:Int? = nil, callback: @escaping (([TestRailTestCase]?, _:String?) -> Void))
	{
		let secID = sectionID != nil ? "\(sectionID!)" : ""
		httpGet(path: "get_cases/\(projectID)&suite_id=\(suiteID)&section_id=\(secID)", type: [TestRailTestCase].self, callback: callback)
	}
	
	
	func getTests(testRunID:Int, callback: @escaping (([TestRailTest]?, _:String?) -> Void))
	{
		httpGet(path: "get_tests/\(testRunID)", type: [TestRailTest].self, callback: callback)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Set API
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Creates a new section for test cases on the TestRail server.
	 */
	func createNewSection(section:TestRailSection, projectID:Int, callback: @escaping ((TestRailSection?, _:String?) -> Void))
	{
		httpPost(path: "add_section/\(projectID)", model: section, type: TestRailSection.self, callback: callback)
	}
	
	
	/**
	 * Creates a new test case on the TestRail server.
	 */
	func createNewTestCase(testCase:TestRailTestCase, sectionID:Int, callback:@escaping ((TestRailTestCase?, _:String?) -> Void))
	{
		httpPost(path: "add_case/\(sectionID)", model: testCase, type: TestRailTestCase.self, callback: callback)
	}
	
	
	/**
	 * Updates a test case on the TestRail server.
	 */
	func updateTestCase(testCase:TestRailTestCase, caseID:Int, callback:@escaping ((TestRailTestCase?, _:String?) -> Void))
	{
		httpPost(path: "update_case/\(caseID)", model: testCase, type: TestRailTestCase.self, callback: callback)
	}
	
	
	/**
	 * Creates a new test run on the TestRail server.
	 */
	func createNewTestRun(testRun:TestRailTestRun, projectID:Int, callback:@escaping ((TestRailTestRun?, _:String?) -> Void))
	{
		httpPost(path: "add_run/\(projectID)", model: testRun, type: TestRailTestRun.self, callback: callback)
	}
	
	
	/**
	 * Updates an existing test run on the TestRail server.
	 */
	func updateTestRun(testRun:TestRailTestRun, callback:@escaping ((TestRailTestRun?, _:String?) -> Void))
	{
		httpPost(path: "update_run/\(testRun.id)", model: testRun, type: TestRailTestRun.self, callback: callback)
	}
	
	
	/**
	 * Adds a new test casde result on the TestRail server.
	 */
	func addTestCaseResult(testRunID:Int, caseID:Int, testCaseResult:TestRailTestResult, callback:@escaping ((TestRailTestResult?, _:String?) -> Void))
	{
		httpPost(path: "add_result_for_case/\(testRunID)/\(caseID)", model: testCaseResult, type: TestRailTestResult.self, callback: callback)
	}
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Delete API
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Deletes a section from the TestRail server.
	 */
	func deleteSection(sectionID:Int, callback: @escaping ((_:String?) -> Void))
	{
		httpPost(path: "delete_section/\(sectionID)", callback: callback)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Server Data Retrieval
	// ----------------------------------------------------------------------------------------------------
	
	private func getTestRailProjects()
	{
		_isTestRailRetrievalComplete = false
		getProjects()
		{
			(response:[TestRailProject]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				self.model.testrailProjects = r
				AutumnLog.debug("Retrieved \(r.count) TestRail projects.\(self.config.debug ? ("\(self.dump(self.model.testrailProjects))") : "")")
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	private func getTestRailSuites()
	{
		_isTestRailRetrievalComplete = false
		getSuites(projectID: config.testrailProjectID)
		{
			(response:[TestRailSuite]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				self.model.testrailSuites = r
				/* Find ID of master suite. */
				for suite in self.model.testrailSuites
				{
					if suite.isMaster == true
					{
						self.model.testrailMasterSuiteID = suite.id
						break
					}
				}
				AutumnLog.debug("Retrieved \(r.count) TestRail suites. (MasterID: \(self.model.testrailMasterSuiteID))\(self.config.debug ? ("\(self.dump(self.model.testrailSuites))") : "")")
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	private func getTestRailUsers()
	{
		_isTestRailRetrievalComplete = false
		getUsers()
		{
			(response:[TestRailUser]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				self.model.testrailUsers = r
				AutumnLog.debug("Retrieved \(r.count) TestRail users.\(self.config.debug ? ("\(self.dump(self.model.testrailUsers))") : "")")
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	private func getTestRailMilestones()
	{
		_isTestRailRetrievalComplete = false
		getMilestones(projectID: config.testrailProjectID)
		{
			(response:[TestRailMilestone]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				self.model.testrailMilestones = r
				AutumnLog.debug("Retrieved \(r.count) TestRail milestones.\(self.config.debug ? ("\(self.dump(self.model.testrailMilestones))") : "")")
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	private func getTestRailStatuses()
	{
		_isTestRailRetrievalComplete = false
		getStatuses()
		{
			(response:[TestRailStatus]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				self.model.testrailStatuses = r
				AutumnLog.debug("Retrieved \(r.count) TestRail statuses.\(self.config.debug ? ("\(self.dump(self.model.testrailStatuses))") : "")")
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	private func getTestRailTestCaseFields()
	{
		_isTestRailRetrievalComplete = false
		getTestCaseFields()
		{
			(response:[TestRailTestCaseField]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				self.model.testrailCaseFields = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test case fields.\(self.config.debug ? ("\(self.dump(self.model.testrailCaseFields))") : "")")
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	private func getTestRailTestCaseTypes()
	{
		_isTestRailRetrievalComplete = false
		getTestCaseTypes()
		{
			(response:[TestRailTestCaseType]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				self.model.testrailCaseTypes = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test case types.\(self.config.debug ? ("\(self.dump(self.model.testrailCaseTypes))") : "")")
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	private func getTestRailTemplates()
	{
		_isTestRailRetrievalComplete = false
		getTemplates(projectID: config.testrailProjectID)
		{
			(response:[TestRailTemplate]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				self.model.testrailTemplates = r
				AutumnLog.debug("Retrieved \(r.count) TestRail templates.\(self.config.debug ? ("\(self.dump(self.model.testrailTemplates))") : "")")
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	private func getTestRailTestPlans()
	{
		_isTestRailRetrievalComplete = false
		getTestPlans(projectID: config.testrailProjectID)
		{
			(response:[TestRailTestPlan]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				self.model.testrailPlans = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test plans.\(self.config.debug ? ("\(self.dump(self.model.testrailPlans))") : "")")
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	private func getTestRailTestCaseSections()
	{
		_isTestRailRetrievalComplete = false
		var retrievedSections:[TestRailSection]?
		getTestCaseSections(projectID: config.testrailProjectID, suiteID: model.testrailMasterSuiteID)
		{
			(response:[TestRailSection]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				retrievedSections = r
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
		
		/* Filter out any sections that are not under automation root section. */
		if let retSections = retrievedSections
		{
			/* Find the root section in the retrieved sections. */
			let rootSections = retSections.filter()
			{
				return ($0).parentID == nil && ($0).name == config.testrailRootSectionName
			}
			
			if rootSections.count == 1
			{
				model.testRailRootSection = rootSections[0]
				//AutumnLog.debug("Found automation root section with ID \(model.testRailRootSection.id).")
				model.testrailSections = retSections.filter()
				{
					return ($0).isRoot() || ($0).parentID == model.testRailRootSection?.id
				}
				AutumnLog.debug("Retrieved \(model.testrailSections.count) TestRail test case sections.\(config.debug ? ("\(dump(model.testrailSections))") : "")")
			}
		}
	}
	
	
	private func getTestRailTestRuns()
	{
		_isTestRailRetrievalComplete = false
		getTestRuns(projectID: config.testrailProjectID)
		{
			(response:[TestRailTestRun]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				self.model.testrailRuns = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test runs.\(self.config.debug ? ("\(self.dump(self.model.testrailRuns))") : "")")
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	private func getTestRailTests()
	{
		_isTestRailRetrievalComplete = false
		if model.testrailTestRunID == 0
		{
			self._isTestRailRetrievalComplete = true
			return
		}
		getTests(testRunID: model.testrailTestRunID)
		{
			(response:[TestRailTest]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				self.model.testrailTests = r
				AutumnLog.debug("Retrieved \(r.count) TestRail tests.\(self.config.debug ? ("\(self.dump(self.model.testrailTests))") : "")")
			}
			self._isTestRailRetrievalComplete = true
		}
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	private func getTestRailTestCases()
	{
		if model.testrailSections.count < 1
		{
			AutumnLog.debug("No test cases exist in automation section yet.")
		}
		else
		{
			_isTestRailRetrievalComplete = false
			var testCases = [TestRailTestCase]()
			var count = 0
			for section in model.testrailSections
			{
				getTestCases(projectID: config.testrailProjectID, suiteID: model.testrailMasterSuiteID, sectionID: section.id)
				{
					(response:[TestRailTestCase]?, error:String?) in
					if let error = error { AutumnLog.error(error) }
					if let r = response
					{
						testCases.append(contentsOf: r)
						AutumnLog.debug("Retrieved \(r.count) TestRail test cases for section \"\(section.name)\".\(self.config.debug ? ("\(self.dump(testCases))") : "")")
					}
					if count == self.model.testrailSections.count - 1
					{
						self._isTestRailRetrievalComplete = true
					}
					count += 1
				}
			}
			AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
			model.testrailCases = testCases
			AutumnLog.debug("Retrieved \(model.testrailCases.count) TestRail test cases in total.")
		}
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - HTTP Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Sends HTTP GET requests to TestRail.
	 */
	func httpGet<T:Codable>(path:String, type:T.Type, callback: @escaping ((T?, String?) -> Void))
	{
		let urlString = getURLFor(path)
		guard let url = URL(string: urlString) else
		{
			callback(nil, "HTTP request failed: Failed to create URL from \"\(urlString)\".")
			return
		}
		guard let authData = self.authData else
		{
			callback(nil, "HTTP request failed: Failed to create auth data.")
			return
		}
		
		let headers:HTTPHeaders =
		[
			"Authorization": "Basic \(authData.base64EncodedString())",
			"Content-Type": "application/json",
			"Content-Length": "0"
		]
		
		Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
			.validate(statusCode: 200 ..< 300)
			.responseJSON(queue: dispatchQueue, options: .allowFragments, completionHandler:
		{
			(response:DataResponse<Any>) in
			switch (response.result)
			{
				case .success(_):
					if let data = response.data //, let utf8Text = String(data: data, encoding: .utf8)
					{
						let decoder = JSONDecoder()
						var decodedModel:T?
						do
						{
							decodedModel = try decoder.decode(type, from: data)
							callback(decodedModel, nil)
						}
						catch let e as DecodingError
						{
							callback(nil, "Failed to decode JSON response. DecodingError: \(e.localizedDescription)")
						}
						catch let e
						{
							callback(nil, "Failed to decode JSON response. Error: \(e.localizedDescription)")
						}
					}
				case .failure(_):
					let errorDescr = response.error != nil ? response.error!.localizedDescription : ""
					var content = "(No JSON in response)"
					if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
					{
						content = utf8Text
					}
					callback(nil, "HTTP request for \(url.absoluteString) failed: \(errorDescr) \(content)")
			}
		})
	}
	
	
	/**
	 * Sends HTTP POST requests to TestRail.
	 */
	func httpPost<T:Codable>(path:String, model:T, type:T.Type, callback: @escaping ((T?, String?) -> Void))
	{
		let encoder = JSONEncoder()
		var encodedJSON:Any?
		do
		{
			encodedJSON = try encoder.encode(model)
		}
		catch let e
		{
			callback(nil, "Failed to encode data model. EncodingError: \(e.localizedDescription)")
		}
		
		if let jsonData = encodedJSON as? Data
		{
			let urlString = getURLFor(path)
			guard let url = URL(string: urlString) else
			{
				callback(nil, "HTTP request failed: Failed to create URL from \"\(urlString)\".")
				return
			}
			guard let authData = self.authData else
			{
				callback(nil, "HTTP request failed: Failed to create auth data.")
				return
			}
			
			var request = URLRequest(url: url)
			request.httpMethod = "POST"
			request.setValue("Basic \(authData.base64EncodedString())", forHTTPHeaderField: "Authorization")
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.setValue("\(jsonData.count)", forHTTPHeaderField: "Content-Length")
			request.httpBody = jsonData
			
			Alamofire.request(request)
				.validate(statusCode: 200 ..< 300)
				.responseJSON(queue: dispatchQueue, options: .allowFragments, completionHandler:
			{
				(response:DataResponse<Any>) in
				switch (response.result)
				{
					case .success(_):
						if let data = response.data //, let utf8Text = String(data: data, encoding: .utf8)
						{
							let decoder = JSONDecoder()
							var decodedModel:T?
							do
							{
								decodedModel = try decoder.decode(type, from: data)
								callback(decodedModel, nil)
							}
							catch let e as DecodingError
							{
								callback(nil, "Failed to decode JSON response. DecodingError: \(e.localizedDescription)")
							}
							catch let e
							{
								callback(nil, "Failed to decode JSON response. Error: \(e.localizedDescription)")
							}
						}
						return
					case .failure(_):
						let errorDescr = response.error != nil ? response.error!.localizedDescription : ""
						var content = "(No JSON in response)"
						if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
						{
							content = utf8Text
						}
						callback(nil, "HTTP request for \(url.absoluteString) failed: \(errorDescr) \(content)")
						return
				}
			})
		}
	}
	
	
	/**
	 * Simple HTTP POST request to TestRail.
	 */
	func httpPost(path:String, callback: @escaping ((String?) -> Void))
	{
		let urlString = getURLFor(path)
		guard let url = URL(string: urlString) else
		{
			callback("HTTP request failed: Failed to create URL from \"\(urlString)\".")
			return
		}
		guard let authData = self.authData else
		{
			callback("HTTP request failed: Failed to create auth data.")
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("Basic \(authData.base64EncodedString())", forHTTPHeaderField: "Authorization")
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		Alamofire.request(request)
			.validate(statusCode: 200 ..< 300)
			.responseJSON(queue: dispatchQueue, options: .allowFragments, completionHandler:
			{
				(response:DataResponse<Any>) in
				switch (response.result)
				{
					case .success(_):
						callback(nil)
						return
					case .failure(_):
						let errorDescr = response.error != nil ? response.error!.localizedDescription : ""
						var content = "(No JSON in response)"
						if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
						{
							content = utf8Text
						}
						callback("HTTP request for \(url.absoluteString) failed: \(errorDescr) \(content)")
						return
				}
			})
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Helpers
	// ----------------------------------------------------------------------------------------------------
	
	/// return the RESTFul API url
	/// - Returns: the RESTFul API url.
	///
	func getURLFor(_ path:String) -> String
	{
		return "\(config.testrailHost)/index.php?/api/v2/\(path)"
	}
	
	
	func dump<T:TestRailCodable>(_ model:[T], _ maxRows:Int = 20) -> String
	{
		if model.count > 0
		{
			let headers = model[0].tableHeader()
			let table = TabularText(headers.count, false, " ", " ", "", 100, headers)
			var i = 0
			for obj in model
			{
				table.add(obj.toTableRow())
				i += 1
				if maxRows > 0 && i >= maxRows { break }
			}
			return "\n\(table.toString())"
		}
		return ""
	}
}
