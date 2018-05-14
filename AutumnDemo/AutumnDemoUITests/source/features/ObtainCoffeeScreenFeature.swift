//
// ObtainCoffeeScreenFeature.swift
// AutumnDemo
//
// Created by Sascha Balkau
//

import Foundation
import Autumn


class ObtainCoffeeScreenFeature : AutumnFeature
{
	override func setup()
	{
		name = "Obtain Coffee Screen Feature"
		descr = "Features for the Demo App Obtain Coffee Screen"
		tags = ["coffee screen", "demo"]
	}
	
	
	override func registerScenarios()
	{
	}
	
	
	override func preLaunch()
	{
	}
	
	
	override func resetApp() -> Bool
	{
		return super.resetApp()
	}
	
	
	override func gotoView(_ viewID:AutumnViewProxy.Type, _ ready:Bool) -> Bool
	{
		return super.gotoView(viewID, ready)
	}
}
