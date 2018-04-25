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
		id = 1
		title = "Autumn Demo Scenario 001"
	}
	
	override func establish()
	{
		given(LaunchApp())
	}
	
	override func execute()
	{
		when(WaitForExists(ACI.APP_VIEW, .other))
		when(Wait(2))
		when(WaitForExists(ACI.NON_EXISTING_VIEW))
		then(AssertExists(ACI.APP_VIEW, .other))
	}
}


// ------------------------------------------------------------------------------------------------
class AutumnDemoScenario002 : AutumnScenario
{
	override func setup()
	{
		id = 2
		title = "Autumn Demo Scenario 002"
	}
	
	override func establish()
	{
		given(LaunchApp())
		given(WaitForExists(ACI.APP_VIEW, .other))
	}
	
	override func execute()
	{
		when(WaitForExists(ACI.APP_LOGIN_PROMPT_LABEL))
		when(LoginRandom(ACI.APP_USERNAME_INPUT_FIELD, ACI.APP_PASSWORD_INPUT_FIELD, ACI.APP_LOGIN_BUTTON))
		then(WaitForHittable(ACI.APP_MORE_STUFF_VIEW))
		when(Wait(5))
		then(Declare("the user waited for 5 seconds"))
	}
}


// ------------------------------------------------------------------------------------------------
class AutumnDemoScenario003 : AutumnScenario
{
	override func setup()
	{
		id = 3
		title = "Autumn Demo Scenario 003"
	}
	
	override func establish()
	{
		given(LaunchApp())
		given(WaitForExists(ACI.APP_VIEW, .other))
	}
	
	override func execute()
	{
		when(WaitForExists(ACI.APP_LOGIN_PROMPT_LABEL))
		when(LoginRandom(ACI.APP_USERNAME_INPUT_FIELD, ACI.APP_PASSWORD_INPUT_FIELD, ACI.APP_LOGIN_BUTTON))
		then(WaitForHittable(ACI.APP_MORE_STUFF_VIEW))
		when(Wait(4))
		then(Declare("the user waited for 4 seconds"))
	}
}


// ------------------------------------------------------------------------------------------------
class AutumnDemoScenario004 : AutumnScenario
{
	override func setup()
	{
		id = 4
		title = "Autumn Demo Scenario 004"
	}
	
	override func establish()
	{
		given(LaunchApp())
		given(WaitForExists(ACI.APP_VIEW, .other))
	}
	
	override func execute()
	{
		when(WaitForExists(ACI.APP_LOGIN_PROMPT_LABEL))
		when(LoginRandom(ACI.APP_USERNAME_INPUT_FIELD, ACI.APP_PASSWORD_INPUT_FIELD, ACI.APP_LOGIN_BUTTON))
		then(WaitForHittable(ACI.APP_MORE_STUFF_VIEW))
		when(Wait(10))
		then(Declare("the user waited for 10 seconds"))
	}
}


// ------------------------------------------------------------------------------------------------
class AutumnDemoScenario005 : AutumnScenario
{
	override func setup()
	{
		id = 5
		title = "Autumn Demo Scenario 005"
		status = .Pending
	}
	
	override func establish()
	{
	}
	
	override func execute()
	{
	}
}


// ------------------------------------------------------------------------------------------------
class AutumnDemoScenario006 : AutumnScenario
{
	override func setup()
	{
		id = 6
		title = "Autumn Demo Scenario 006"
		status = .Unsupported
	}
	
	override func establish()
	{
	}
	
	override func execute()
	{
	}
}
