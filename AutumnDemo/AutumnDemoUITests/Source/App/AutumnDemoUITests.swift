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
		config.testrailUserEmail = "ts-balkau.sascha@rakuten.com"
		config.testrailPassword  = "4SHoBxMKzQVRcDBdijM4-6Nai8TTWGoUBPKBALBLw"
		config.testrailProjectID = 4
		config.testrailTestType  = .Functional
		config.isStagingBuild    = true
		config.logInstructions   = true
		config.debug             = true
	}
	
	
	override func registerUsers()
	{
		registerUser(AutumnUser("James Seth Lynch", "MyUltraSecretExtraLongPassword12345%!", "Lynch"), isDefaultSTG: true)
		registerUser(AutumnUser("Norman Bates", "MyMotherIsMyLove", "Bates"), isDefaultPRD: true)
		registerUser(AutumnUser("Patrick Bateman", "HeadsInFridges", "Bateman"))
		registerUser(AutumnUser("Fred Kraeger", "Claws666!LOLwut#", "Freddy"))
		registerUser(AutumnUser("Hannibal Lecter", "Bodies123OmnomnomFTW$", "Lecter"))
		registerUser(AutumnUser("Michael Myers", "LookUnderYourBedBeforeSleeping!", "MaskFace"))
		registerUser(AutumnUser("Catherine Tramell", "BetweenTeheLegs", "Cathy"))
		registerUser(AutumnUser("Jason Voorhees", "ILoveTeenies!$^*%", "Jason"))
	}
	
	
	override func registerViewProxies()
	{
		registerViewProxy(AutumnDemoViewProxy.self, "Demo View Proxy")
	}
	
	
	override func registerFeatures()
	{
		registerFeature(AutumnDemoFeature.self)
		registerFeature(AutumnDemoFeature2.self)
	}
}
