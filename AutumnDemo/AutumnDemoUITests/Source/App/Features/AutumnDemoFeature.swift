//
// AutumnDemoFeature.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/02.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


class AutumnDemoFeature : AutumnFeature
{
	override func setup()
	{
		name = "Autumn Demo Feature"
		tags = ["autumn", "demo"]
	}
	
	
	override func registerScenarios()
	{
		registerScenario(AutumnDemoScenario001.self)
		registerScenario(AutumnDemoScenario002.self)
	}
	
	
	override func preLaunch()
	{
	}
	
	
	override func resetApp() -> Bool
	{
		return false
	}
	
	
	override func gotoView(_ viewID:AutumnViewProxy.Type, _ ready:Bool) -> Bool
	{
		return false
	}
}
