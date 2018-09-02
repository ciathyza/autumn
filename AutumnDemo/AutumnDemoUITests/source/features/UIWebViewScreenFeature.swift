//
// UIWebViewScreenFeature.swift
// AutumnDemo
//
// Created by Ciathyza
//

import Foundation
import Autumn


class UIWebViewScreenFeature : AutumnFeature
{
	override func setup()
	{
		name = "UIWebView Screen"
		descr = "Test scenarios for the demo app UIWebView screen"
		tags = ["UIWebView", "demo"]
	}
	
	
	override func registerScenarios()
	{
		registerScenario(UIWebViewScreenScenario001.self)
	}
}
