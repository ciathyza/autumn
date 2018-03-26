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
	
	func getProjects(callback: @escaping (([TestRailProject]?, _:String?) -> Void))
	{
		httpGet(path: "get_projects", type: [TestRailProject].self, callback: callback)
	}
	
	
	func getSuites(projectID:String, callback: @escaping (([TestRailSuite]?, _:String?) -> Void))
	{
		httpGet(path: "get_suites/\(projectID)", type: [TestRailSuite].self, callback: callback)
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
								let decoder = JSONDecoder()
								var decodedModel:T?
								do
								{
									decodedModel = try! decoder.decode(type, from: data)
									callback(decodedModel, nil)
								}
								catch let error as Error
								{
									callback(nil, "Failed to decode JSON response. Error was: \(error.localizedDescription)")
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
