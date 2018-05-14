//
// TestMenuScreenScenarios.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/05/14.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation
import Autumn


class ScenarioEnterTestMenuScreen : AutumnScenario
{
	override func setup()
	{
		id = 1
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
