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
	
	private var _isTestRailRetrievalComplete = false
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Derived Properties
	// ----------------------------------------------------------------------------------------------------
	
	var authString:String
	{
		return "\(AutumnTestRunner.instance.config.testrailUsername)" +
				":\(AutumnTestRunner.instance.config.testrailPassword)"
	}
	var authData:Data? { return authString.data(using: .ascii) }
	
	let dispatchQueue = DispatchQueue(label: "com.autumn.manager-response-queue", qos: .userInitiated, attributes:.concurrent)
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Non-Async method to retrieve all TestRail data.
	 */
	func retrieveTestRailData()
	{
		/* Yep, this cumbersome structure for fetching async data from server is required for the wait API to work with XCTest. */
		
		getTestRailProjects()
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
		getTestRailSuites()
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
		getTestRailMilestones()
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
		getTestRailStatuses()
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
		getTestRailTestCaseFields()
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
		getTestRailTestCaseTypes()
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
		getTestRailTestPlans()
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
		getTestRailTestCaseSections()
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
		getTestRailTestRuns()
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
		getTestRailTestCases()
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
				AutumnTestRunner.instance.testRailModel.statuses = r
				AutumnLog.debug("Retrieved \(r.count) TestRail statuses.")
			}
			self._isTestRailRetrievalComplete = true
		}
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
				AutumnTestRunner.instance.testRailModel.testCaseFields = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test case fields.")
			}
			self._isTestRailRetrievalComplete = true
		}
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
				AutumnTestRunner.instance.testRailModel.testCaseTypes = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test case types.")
			}
			self._isTestRailRetrievalComplete = true
		}
	}
	
	
	private func getTestRailTestCaseSections()
	{
		_isTestRailRetrievalComplete = false
		getTestCaseSections(projectID: AutumnTestRunner.instance.config.testrailProjectID, suiteID: AutumnTestRunner.instance.testRailModel.masterSuiteID)
		{
			(response:[TestRailSection]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				AutumnTestRunner.instance.testRailModel.sections = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test case sections.")
			}
			self._isTestRailRetrievalComplete = true
		}
	}
	
	
	private func getTestRailProjects()
	{
		_isTestRailRetrievalComplete = false
		getProjects()
		{
			(response:[TestRailProject]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				AutumnTestRunner.instance.testRailModel.projects = r
				AutumnLog.debug("Retrieved \(r.count) TestRail projects.")
			}
			self._isTestRailRetrievalComplete = true
		}
	}
	
	
	private func getTestRailSuites()
	{
		_isTestRailRetrievalComplete = false
		getSuites(projectID: AutumnTestRunner.instance.config.testrailProjectID)
		{
			(response:[TestRailSuite]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				AutumnTestRunner.instance.testRailModel.suites = r
				/* Find ID of master suite. */
				for suite in AutumnTestRunner.instance.testRailModel.suites
				{
					if suite.isMaster == true
					{
						AutumnTestRunner.instance.testRailModel.masterSuiteID = suite.id
						break
					}
				}
				AutumnLog.debug("Retrieved \(r.count) TestRail suites. (MasterID: \(AutumnTestRunner.instance.testRailModel.masterSuiteID))")
			}
			self._isTestRailRetrievalComplete = true
		}
	}
	
	
	private func getTestRailMilestones()
	{
		_isTestRailRetrievalComplete = false
		getMilestones(projectID: AutumnTestRunner.instance.config.testrailProjectID)
		{
			(response:[TestRailMilestone]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				AutumnTestRunner.instance.testRailModel.milestones = r
				AutumnLog.debug("Retrieved \(r.count) TestRail milestones.")
			}
			self._isTestRailRetrievalComplete = true
		}
	}
	
	
	private func getTestRailTestPlans()
	{
		_isTestRailRetrievalComplete = false
		getTestPlans(projectID: AutumnTestRunner.instance.config.testrailProjectID)
		{
			(response:[TestRailTestPlan]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				AutumnTestRunner.instance.testRailModel.testPlans = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test plans.")
			}
			self._isTestRailRetrievalComplete = true
		}
	}
	
	
	private func getTestRailTestRuns()
	{
		_isTestRailRetrievalComplete = false
		getTestRuns(projectID: AutumnTestRunner.instance.config.testrailProjectID)
		{
			(response:[TestRailTestRun]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				AutumnTestRunner.instance.testRailModel.testRuns = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test runs.")
			}
			self._isTestRailRetrievalComplete = true
		}
	}
	
	
	private func getTestRailTestCases()
	{
		_isTestRailRetrievalComplete = false
		getTestCases(projectID: AutumnTestRunner.instance.config.testrailProjectID, suiteID: AutumnTestRunner.instance.testRailModel.masterSuiteID)
		{
			(response:[TestRailTestCase]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				AutumnTestRunner.instance.testRailModel.testCases = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test cases.")
			}
			self._isTestRailRetrievalComplete = true
		}
	}
	
	
	private func getTestRailTests()
	{
		_isTestRailRetrievalComplete = false
		getTests(testRunID: AutumnTestRunner.instance.config.testrailTestRunID)
		{
			(response:[TestRailTest]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				AutumnTestRunner.instance.testRailModel.tests = r
				AutumnLog.debug("Retrieved \(r.count) TestRail tests.")
			}
			self._isTestRailRetrievalComplete = true
		}
	}
	
	
	func ensureServerState()
	{
		ensureTestCaseSection()
		AutumnUI.waitUntil { return self._isTestRailRetrievalComplete }
	}
	
	
	func ensureTestCaseSection()
	{
		_isTestRailRetrievalComplete = false
		AutumnLog.debug("Getting section used for generated test cases ...")
		let sectionName = AutumnTestRunner.instance.config.testrailSectionName
		if let section = AutumnTestRunner.instance.testRailModel.getSection(sectionName: sectionName)
		{
			/* A section with the name already exists. */
			AutumnTestRunner.instance.testRailModel.section = section
			AutumnLog.debug("Found existing \(sectionName) section with ID \(section.id).")
			_isTestRailRetrievalComplete = true
		}
		else
		{
			/* Create new section to work with! */
			let section = TestRailSection(name: sectionName, description: "Autumn test cases.")
			createNewSection(section: section, projectID: AutumnTestRunner.instance.config.testrailProjectID)
			{
				(response:TestRailSection?, error:String?) in
				if let error = error { AutumnLog.error(error) }
				if let r = response
				{
					AutumnTestRunner.instance.testRailModel.section = r
					AutumnTestRunner.instance.testRailModel.addSection(section: r)
					AutumnLog.debug("Created new \(sectionName) section with ID \(r.id).")
				}
				self._isTestRailRetrievalComplete = true
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
	
	
	func getTestCases(projectID:Int, suiteID:Int, callback: @escaping (([TestRailTestCase]?, _:String?) -> Void))
	{
		httpGet(path: "get_cases/\(projectID)&suite_id=\(suiteID)&section_id=", type: [TestRailTestCase].self, callback: callback)
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
					if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
					{
						let decoder = JSONDecoder()
						var decodedModel:T?
						do
						{
							decodedModel = try! decoder.decode(type, from: data)
							callback(decodedModel, nil)
						}
						catch let e as DecodingError
						{
							callback(nil, "Failed to decode JSON response. DecodingError: \(e.localizedDescription)")
						}
						catch let e as Error
						{
							callback(nil, "Failed to decode JSON response. Error: \(e.localizedDescription)")
						}
					}
				case .failure(_):
					let errorDescr = response.error != nil ? response.error!.localizedDescription : ""
					callback(nil, "HTTP request for \(url.absoluteString) failed: \(errorDescr)")
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
			encodedJSON = try! encoder.encode(model)
		}
		catch let e as Error
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
			
//			if let utf8Text = String(data: jsonData, encoding: .utf8)
//			{
//				Log.debug(">>>", "\(utf8Text)")
//			}
			
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
						if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
						{
							let decoder = JSONDecoder()
							var decodedModel:T?
							do
							{
								decodedModel = try! decoder.decode(type, from: data)
								callback(decodedModel, nil)
							}
							catch let e as DecodingError
							{
								callback(nil, "Failed to decode JSON response. DecodingError: \(e.localizedDescription)")
							}
							catch let e as Error
							{
								callback(nil, "Failed to decode JSON response. Error: \(e.localizedDescription)")
							}
						}
						return
					case .failure(_):
						let errorDescr = response.error != nil ? response.error!.localizedDescription : ""
						callback(nil, "HTTP request for \(url.absoluteString) failed: \(errorDescr)")
						return
				}
			})
		}
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Helpers
	// ----------------------------------------------------------------------------------------------------
	
	/// return the RESTFul API url
	/// - Returns: the RESTFul API url.
	///
	func getURLFor(_ path:String) -> String
	{
		return "\(AutumnTestRunner.instance.config.testrailHost)/index.php?/api/v2/\(path)"
	}
}
