//
// ObtainCoffeeScreenScenarios.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/05/14.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation
import Autumn


class ObtainCoffeeScreenScenario001 : AutumnScenario
{
	override func setup()
	{
		id = 2
		title = "Obtain Coffee Screen Scenario 001"
	}
	
	override func establish()
	{
		given(LaunchApp())
	}
	
	override func execute()
	{
	}
}
