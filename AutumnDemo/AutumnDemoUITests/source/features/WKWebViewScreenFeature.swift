//
// WKWebViewScreenFeature.swift
// AutumnDemo
//
// Created by Ciathyza
//

import Foundation
import Autumn


class WKWebViewScreenFeature : AutumnFeature
{
	override func setup()
	{
		name = "WKWebView Screen"
		descr = "Test scenarios for the demo app WKWebView screen"
		tags = ["WKWebView", "demo"]
	}
	
	
	override func registerScenarios()
	{
		registerScenario(WKWebViewScreenScenario001.self)
	}
}
