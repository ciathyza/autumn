//
// AutumnDemoFeature.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/02.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


class AutumnDemoFeature3 : AutumnFeature
{
	override func setup()
	{
		name = "Autumn Demo Feature Number 3"
		descr = "Yet feature for demoing the framework."
		tags = ["autumn", "demo"]
	}
	
	
	override func registerScenarios()
	{
		registerScenario(AutumnDemoScenario011.self)
		registerScenario(AutumnDemoScenario012.self)
		registerScenario(AutumnDemoScenario013.self)
		registerScenario(AutumnDemoScenario014.self)
		registerScenario(AutumnDemoScenario015.self)
		registerScenario(AutumnDemoScenario016.self)
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
