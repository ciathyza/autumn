//
// CoffeeScreenScenarios.swift
// AutumnDemo
//
// Created by Sascha Balkau
//

import Foundation
import Autumn


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
