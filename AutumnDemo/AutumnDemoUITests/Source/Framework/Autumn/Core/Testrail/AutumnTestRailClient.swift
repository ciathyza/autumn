//
// AutumnTestRailClient.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/22.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


class AutumnTestRailClient
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/// return the RESTFul API url
	/// - Returns: the RESTFul API url.
	///
	func getURLFor(path:String) -> String
	{
		return "\(AutumnTestRunner.instance.config.testrailHost)/index.php?/api/v2/\(path)"
	}
}
