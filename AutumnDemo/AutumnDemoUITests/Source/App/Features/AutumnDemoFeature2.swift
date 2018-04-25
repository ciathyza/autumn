//
// AutumnDemoFeature.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/02.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


class AutumnDemoFeature2 : AutumnFeature
{
	override func setup()
	{
		name = "Autumn Demo Feature Number 2"
		descr = "More feature for demoing the framework."
		tags = ["autumn", "demo"]
	}
	
	
	override func registerScenarios()
	{
		registerScenario(AutumnDemoScenario003.self)
		registerScenario(AutumnDemoScenario004.self)
		registerScenario(AutumnDemoScenario005.self)
		registerScenario(AutumnDemoScenario006.self)
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
