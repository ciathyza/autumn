//
// TestMenuScreenFeature.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/05/14.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation
import Autumn


class TestMenuScreenFeature : AutumnFeature
{
	override func setup()
	{
		name = "Test Menu Screen Feature"
		descr = "Tests for the demo app test menu screen."
		tags = ["menu screen", "demo"]
	}
	
	
	override func registerScenarios()
	{
		registerScenario(ScenarioDisplayTestMenuScreen.self)
	}
	
	
	override func preLaunch()
	{
	}
}
