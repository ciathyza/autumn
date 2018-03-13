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
		when(WaitForExists(ACI.APP_VIEW, .other))
		when(Wait(2))
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
		when(WaitForExists(ACI.APP_VIEW, .other))
	}
	
	override func execute()
	{
		when(WaitForExists(ACI.APP_LOGIN_PROMPT_LABEL))
		when(TypeText(ACI.APP_USERNAME_INPUT_FIELD, "James Seth Lynch"))
		when(TypePassword(ACI.APP_PASSWORD_INPUT_FIELD, "MyUltraSecretExtraLongPassword12345%!"))
		when(Tap(ACI.APP_LOGIN_BUTTON))
		when(Wait(5))
	}
}
