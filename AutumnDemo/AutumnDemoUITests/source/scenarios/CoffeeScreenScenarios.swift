//
// CoffeeScreenScenarios.swift
// AutumnDemo
//
// Created by Sascha Balkau
//

import Foundation
import Autumn


// ------------------------------------------------------------------------------------------------
class ScenarioEnterCoffeeScreen : AutumnScenario
{
	override func setup()
	{
		id = 2
		title = "Enter Coffee Screen"
		descr = "Tests that the coffee screen can be entered and displayed."
	}
	
	override func establish()
	{
		given(LaunchApp())
	}
	
	override func execute()
	{
		when(EnterCoffeeScreen())
		then(AssertHittable(DEMO_COFFEE_VIEW_ACI))
	}
}

// ------------------------------------------------------------------------------------------------
class ScenarioLoginCoffeeScreen : AutumnScenario
{
	override func setup()
	{
		id = 3
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
