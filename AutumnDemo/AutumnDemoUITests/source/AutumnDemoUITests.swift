//
//  AutumnDemoUITests.swift
//  AutumnDemoUITests
//
//  Created by Ciathyza
//

import Foundation
import Autumn


class AutumnDemoUITests : AutumnTestRunner
{
	override func configure()
	{
		config.networkRequestTimeout          = 20
		config.slowSeconds                    = 0
		
		config.projectName                    = "AutumnDemo"
		config.appName                        = "AutumnDemo"
		config.appID                          = "com.ciathyza.AutumnDemo"
		config.testrailHost                   = "https://autumndemo.testrail.net"
		config.testrailUserEmail              = "john.foo@email.com"
		config.testrailPassword               = "7fGRg25REgT54TrGHu1rtEe9erTf"
		config.testrailMilestoneName          = "App 1.0.0"
		config.testrailRootSectionName        = "Autumn Demo App"
		config.testrailRootSectionDescription = "Test cases for the Autumn framework demo app."
		config.testrailProjectID              = 4
		config.testrailTestType               = .Functional
		config.serverType                     = .STG
		config.logInstructions                = true
		config.debug                          = false
	}


	override func registerUsers()
	{
		registerUser(AutumnUser("James Seth Lynch", "MyUltraSecretExtraLongPassword12345%!", "Lynch"), isDefault: true)
		registerUser(AutumnUser("Norman Bates", "MyMotherIsMyLove", "Bates"))
		registerUser(AutumnUser("Patrick Bateman", "HeadsInFridges", "Bateman"))
		registerUser(AutumnUser("Fred Kraeger", "Claws666!LOLwut#", "Freddy"))
		registerUser(AutumnUser("Hannibal Lecter", "Bodies123OmnomnomFTW$", "Lecter"))
		registerUser(AutumnUser("Michael Myers", "LookUnderYourBedBeforeSleeping!", "MaskFace"))
		registerUser(AutumnUser("Catherine Tramell", "BetweenTeheLegs", "Cathy"))
		registerUser(AutumnUser("Jason Voorhees", "ILoveTeenies!$^*%", "Jason"))
	}


	override func registerFeatures()
	{
		registerFeature(TestMenuScreenFeature.self)
		registerFeature(CoffeeScreenFeature.self)
		registerFeature(UIWebViewScreenFeature.self)
		registerFeature(WKWebViewScreenFeature.self)
	}
	
	
	func testRecord()
	{
	}
}
