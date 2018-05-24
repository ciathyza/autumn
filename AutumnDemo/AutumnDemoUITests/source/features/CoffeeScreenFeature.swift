//
// CoffeeScreenFeature.swift
// AutumnDemo
//
// Created by Sascha Balkau
//

import Foundation
import Autumn


class CoffeeScreenFeature : AutumnFeature
{
	override func setup()
	{
		name = "Coffee Screen"
		descr = "Test scenarios for the demo app coffee screen"
		tags = ["coffee screen", "demo"]
	}
	
	
	override func registerScenarios()
	{
		registerScenario(ScenarioCoffeeScreen001.self)
		registerScenario(ScenarioCoffeeScreen002.self)
		registerScenario(ScenarioCoffeeScreen003.self)
		registerScenario(ScenarioCoffeeScreen004.self)
		registerScenario(ScenarioCoffeeScreen005.self)
	}
}
