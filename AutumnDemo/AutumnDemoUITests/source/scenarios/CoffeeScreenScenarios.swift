//
// CoffeeScreenScenarios.swift
// AutumnDemo
//
// Created by Sascha Balkau
//

import Foundation
import Autumn


// ------------------------------------------------------------------------------------------------
class ScenarioCheckCoffeeScreenDisplay : AutumnScenario
{
	override func setup()
	{
		id = "B001"
		title = "Check Coffee Screen Display"
		descr = "Checks correct display of all coffee screen UI elements."
	}
	
	override func establish()
	{
		given(LaunchApp())
		given(EnterCoffeeScreen())
	}
	
	override func execute()
	{
		when(AssertExists(DEMO_COFFEE_VIEW_ACI))
	}
}


// ------------------------------------------------------------------------------------------------
class ScenarioLoginCoffeeScreen : AutumnScenario
{
	override func setup()
	{
		id = "B002"
		title = "Login Coffee Screen"
		descr = "Tests login into the coffee screen."
	}
	
	override func establish()
	{
		given(LaunchApp())
		given(EnterCoffeeScreen())
	}
	
	override func execute()
	{
		when(LoginRandom(DEMO_COFFEE_USERNAME_INPUT_ACI, DEMO_COFFEE_PASSWORD_INPUT_ACI, DEMO_COFFEE_LOGIN_BUTTON_ACI))
		then(AssertHittable(app.alerts["Logged-in!"]))
		then(AssertHittable(app.alerts["Logged-in!"].staticTexts["Logged-in!"]))
		
		when(Tap(app.alerts["Logged-in!"].buttons["Ok"]))
		then(AssertNotExists(app.alerts["Logged-in!"]))
	}
}
