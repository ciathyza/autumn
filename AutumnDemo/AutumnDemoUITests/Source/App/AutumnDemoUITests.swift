//
//  AutumnDemoUITests.swift
//  AutumnDemoUITests
//
//  Created by Sascha, Balkau | FINAD on 2018/02/27.
//  Copyright © 2018 Ciathyza. All rights reserved.
//

import XCTest


class AutumnDemoUITests : AutumnTestRunner
{
	override func configure()
	{
		config.networkRequestTimeout = 20
		
		config.projectName       = "PointPartner"
		config.appName           = "AutumnDemo"
		config.appID             = "com.ciathyza.AutumnDemo"
		config.testrailHost      = "https://pointpartner.testrail.net"
		config.testrailUsername  = "ts-balkau.sascha@rakuten.com"
		config.testrailPassword  = "4SHoBxMKzQVRcDBdijM4-6Nai8TTWGoUBPKBALBLw"
		config.testrailProjectID = 4
		config.isStagingBuild    = true
		config.logInstructions   = true
		config.debug             = true
	}
	
	
	override func registerUsers()
	{
		registerUser(AutumnUser("pp.qa001", "aaaaaa", "PP QA001"), isDefaultSTG: true)
		registerUser(AutumnUser("saschab", "Opal23#", "Production User"), isDefaultPRD: true)
		registerUser(AutumnUser("pvtest4-183@test.com", "rakuten", "Black-Listed User 3,001"))
		registerUser(AutumnUser("pvtest3-185@test.com", "rakuten7", "Black-Listed User 2,999"))
		registerUser(AutumnUser("pvtest3-186@test.com", "rakuten8", "Black-Listed User 3,000"))
	}
	
	
	override func registerViewProxies()
	{
		registerViewProxy(AutumnDemoViewProxy.self, "Demo View Proxy")
	}
	
	
	override func registerFeatures()
	{
		registerFeature(AutumnDemoFeature.self)
	}
}
