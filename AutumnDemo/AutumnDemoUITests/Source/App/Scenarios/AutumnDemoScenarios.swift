//
// AutumnDemoScenarios.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/02.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


// ------------------------------------------------------------------------------------------------
class AutumnDemoScenario001 : AutumnScenario
{
	override func setup()
	{
		id = "scenario001"
		name = "Autumn Demo Scenario 001"
	}
	
	override func establish()
	{
		given(LaunchApp())
	}
	
	override func execute()
	{
		when(WaitForExists(app.otherElements[ACI.APP_VIEW]))
		when(Wait(5))
	}
}


// ------------------------------------------------------------------------------------------------
class AutumnDemoScenario002 : AutumnScenario
{
	override func setup()
	{
		id = "scenario002"
		name = "Autumn Demo Scenario 002"
	}
	
	override func establish()
	{
		given(LaunchApp())
		given(WaitForExists(app.otherElements[ACI.APP_VIEW]))
	}
	
	override func execute()
	{
		when(Wait(2))
		when(Tap(app.otherElements[ACI.APP_VIEW]))
	}
}
