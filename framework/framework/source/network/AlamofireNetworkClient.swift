/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import Foundation
import Alamofire


class AlamofireNetworkClient
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let config:AutumnConfig
	let model:AutumnModel
	let dispatchQueue = DispatchQueue(label: "com.autumn.manager-response-queue", qos: .userInitiated, attributes:.concurrent)
	
	var authString:String { return "\(config.testrailUserEmail)" + ":\(config.testrailPassword)" }
	var authData:Data? { return authString.data(using: .ascii) }
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(_ config:AutumnConfig, _ model:AutumnModel)
	{
		self.config = config
		self.model = model
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
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
							if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
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
									if self.config.debug { AutumnLog.error("Response data: \(utf8Text)") }
								}
								catch let e
								{
									callback(nil, "Failed to decode JSON response. Error: \(e.localizedDescription)")
									if self.config.debug { AutumnLog.error("Response data: \(utf8Text)") }
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
}
