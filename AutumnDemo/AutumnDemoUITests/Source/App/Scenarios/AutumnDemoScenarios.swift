//
// AutumnDemoScenarios.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/02.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


// ------------------------------------------------------------------------------------------------
class AutumnDemoScenario001 : AutumnScenario
{
	override func setup()
	{
		id = "scenario001"
		name = "Autumn Demo Scenario 001"
	}
	
	override func establish()
	{
		step(GivenLaunchApp())
	}
	
	override func execute()
	{
		step(WhenWait(5))
	}
}
