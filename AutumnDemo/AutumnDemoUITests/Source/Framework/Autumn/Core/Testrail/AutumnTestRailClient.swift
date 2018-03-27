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
	
	private var _isTestRailDataRetriveStepDone = false
	
	
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
		let model = AutumnTestRunner.instance.testRailModel
		let projectID = AutumnTestRunner.instance.config.testrailProjectID
		
		/* Projects */
		_isTestRailDataRetriveStepDone = false
		getProjects()
		{
			(response:[TestRailProject]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				model.projects = r
				AutumnLog.debug("Retrieved \(r.count) TestRail projects.")
			}
			self._isTestRailDataRetriveStepDone = true
		}
		AutumnUI.waitUntil { return self._isTestRailDataRetriveStepDone }
		
		/* Suites */
		_isTestRailDataRetriveStepDone = false
		getSuites(projectID: projectID)
		{
			(response:[TestRailSuite]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				model.suites = r
				/* Find ID of master suite. */
				for suite in model.suites
				{
					if let isMaster = suite.isMaster, isMaster == true
					{
						model.masterSuiteID = "\(suite.id!)"
						break
					}
				}
				AutumnLog.debug("Retrieved \(r.count) TestRail suites. (MasterID: \(model.masterSuiteID))")
			}
			self._isTestRailDataRetriveStepDone = true
		}
		AutumnUI.waitUntil { return self._isTestRailDataRetriveStepDone }
		
		/* Milestones */
		_isTestRailDataRetriveStepDone = false
		getMilestones(projectID: projectID)
		{
			(response:[TestRailMilestone]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				model.milestones = r
				AutumnLog.debug("Retrieved \(r.count) TestRail milestones.")
			}
			self._isTestRailDataRetriveStepDone = true
		}
		AutumnUI.waitUntil { return self._isTestRailDataRetriveStepDone }
		
		/* Test plans */
		_isTestRailDataRetriveStepDone = false
		getTestPlans(projectID: projectID)
		{
			(response:[TestRailTestPlan]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				model.testPlans = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test plans.")
			}
			self._isTestRailDataRetriveStepDone = true
		}
		AutumnUI.waitUntil { return self._isTestRailDataRetriveStepDone }
		
		/* Test runs */
		_isTestRailDataRetriveStepDone = false
		getTestRuns(projectID: projectID)
		{
			(response:[TestRailTestRun]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				model.testRuns = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test runs.")
			}
			self._isTestRailDataRetriveStepDone = true
		}
		AutumnUI.waitUntil { return self._isTestRailDataRetriveStepDone }
		
		/* Test cases */
		_isTestRailDataRetriveStepDone = false
		getTestCases(projectID: projectID, suiteID: model.masterSuiteID)
		{
			(response:[TestRailTestCase]?, error:String?) in
			if let error = error { AutumnLog.error(error) }
			if let r = response
			{
				model.testCases = r
				AutumnLog.debug("Retrieved \(r.count) TestRail test cases.")
			}
			self._isTestRailDataRetriveStepDone = true
		}
		AutumnUI.waitUntil { return self._isTestRailDataRetriveStepDone }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Get API
	// ----------------------------------------------------------------------------------------------------
	
	func getProjects(callback: @escaping (([TestRailProject]?, _:String?) -> Void))
	{
		httpGet(path: "get_projects", type: [TestRailProject].self, callback: callback)
	}
	
	
	func getSuites(projectID:String, callback: @escaping (([TestRailSuite]?, _:String?) -> Void))
	{
		httpGet(path: "get_suites/\(projectID)", type: [TestRailSuite].self, callback: callback)
	}
	
	
	func getMilestones(projectID:String, callback: @escaping (([TestRailMilestone]?, _:String?) -> Void))
	{
		httpGet(path: "get_milestones/\(projectID)", type: [TestRailMilestone].self, callback: callback)
	}
	
	
	func getTestPlans(projectID:String, callback: @escaping (([TestRailTestPlan]?, _:String?) -> Void))
	{
		httpGet(path: "get_plans/\(projectID)", type: [TestRailTestPlan].self, callback: callback)
	}
	
	
	func getTestRuns(projectID:String, callback: @escaping (([TestRailTestRun]?, _:String?) -> Void))
	{
		httpGet(path: "get_runs/\(projectID)", type: [TestRailTestRun].self, callback: callback)
	}
	
	
	func getTestCases(projectID:String, suiteID:String, callback: @escaping (([TestRailTestCase]?, _:String?) -> Void))
	{
		httpGet(path: "get_cases/4\(projectID)&suite_id=\(suiteID)&section_id=/", type: [TestRailTestCase].self, callback: callback)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - HTTP Methods
	// ----------------------------------------------------------------------------------------------------
	
	/// Sends HTTP GET requests to TestRail.
	///
	/// - Parameters:
	/// 	- path: The URL path of the Testrail API.
	/// 	- model: The data model object used to contain fetched data.
	/// 	- callback: Optional closure that is invoked after the request completed.
	///
	func httpGet<T:Codable>(path:String, type:T.Type, callback: @escaping ((T?, String?) -> Void))
	{
		let urlString = getURLFor(path)
		guard let url = URL(string: urlString) else
		{
			let errorString = "HTTP request failed: Failed to create URL from \"\(urlString)\"."
			//if let cb = callback { cb(model) }
			return
		}
		guard let authData = self.authData else
		{
			let errorString = "HTTP request failed: Failed to create auth data."
			//if let cb = callback { cb(model) }
			return
		}
		
		let headers:HTTPHeaders =
		[
			"Authorization": "Basic \(authData.base64EncodedString())",
			"Content-Type": "application/json",
			"Content-Length": "0"
		]
		
		if AutumnTestRunner.instance.config.debug
		{
			Log.debug("Debug", "Making HTTP GET request to \"\(urlString)\" ...")
		}
		
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
								if AutumnTestRunner.instance.config.debug
								{
									Log.debug("Debug", "\(utf8Text)")
								}
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
							callback(nil, "HTTP request failed: \(errorDescr)")
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
		return "\(AutumnTestRunner.instance.config.testrailHost)/index.php?/api/v2/\(path)"
	}
}
