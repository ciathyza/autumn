//
// TestMenuScreenFeature.swift
// AutumnDemo
//
// Created by Ciathyza
//

import Foundation
import Autumn


class TestMenuScreenFeature : AutumnFeature
{
	override func setup()
	{
		name = "Test Menu Screen"
		descr = "Test scenarios for the demo app test menu screen."
		tags = ["menu screen", "demo"]
	}
	
	
	override func registerScenarios()
	{
		registerScenario(ScenarioTestMenuScreen001.self)
	}
}
