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
		name = "Coffee Screen Feature"
		descr = "Features for the Demo App Coffee Screen"
		tags = ["coffee screen", "demo"]
	}
	
	
	override func registerScenarios()
	{
		//registerScenario(ScenarioEnterCoffeeScreen.self)
		registerScenario(ScenarioLoginCoffeeScreen.self)
	}
}
