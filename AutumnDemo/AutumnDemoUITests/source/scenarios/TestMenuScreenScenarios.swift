//
// TestMenuScreenScenarios.swift
// AutumnDemo
//
// Created by Sascha Balkau
//

import Foundation
import Autumn


// ------------------------------------------------------------------------------------------------
class ScenarioTestMenuScreen001: AutumnScenario
{
	override func setup()
	{
		id = "STMS001"
		title = "Enter Test Menu Screen"
		descr = "Tests that the test menu screen can be entered and displayed."
	}
	
	override func establish()
	{
		given(LaunchApp())
	}
	
	override func execute()
	{
		when(EnterTestMenuScreen())
		then(AssertHittable(DEMO_TEST_MENU_SCREEN_VIEW_ACI))
	}
}
