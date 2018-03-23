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
	
	func getProjects(callback:((Codable) -> Void)? = nil)
	{
		httpGet(path: "get_projects", model: [TestRailProject](), callback: callback)
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
	func httpGet(path:String, model:[Codable], callback:((Codable) -> Void)? = nil)
	{
		let urlString = getURLFor(path)
		guard let url = URL(string: urlString) else
		{
			onHTTPRequestError(result: nil, error: "Failed to create URL from \"\(urlString)\"", model: model, callback: callback)
			return
		}
		guard let authData = self.authData else
		{
			onHTTPRequestError(result: nil, error: "Failed to create auth data", model: model, callback: callback)
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
				if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
				{
					//Log.debug(">>>" , "\(utf8Text)")
				}
				switch (response.result)
				{
					case .success(_):
						self.onHTTPRequestComplete(result: response.result, model: model, callback: callback)
					case .failure(_):
						self.onHTTPRequestError(result: response.result, error: "\(response.error!)", model: model, callback: callback)
				}
			})
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Handlers
	// ----------------------------------------------------------------------------------------------------
	
	func onHTTPRequestComplete(result:Result<Any>, model:[Codable], callback:((Codable) -> Void)? = nil)
	{
		if let closure = callback
		{
			//let parsedModel = parseResultDataToModel(result: result, model: model)
			//closure(parsedModel)
		}
	}
	
	
	func onHTTPRequestError(result:Result<Any>?, error:String, model:[Codable], callback:((Codable) -> Void)? = nil)
	{
		let errorString = "HTTP request failed: \(error).\(result != nil ? " Result: \(result!)" : "")"
		//let parsedModel = parseResultDataToModel(result: result, model: model)
		//parsedModel.error = errorString
		//if let closure = callback { closure(parsedModel) }
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
