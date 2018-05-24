//
// WKWebViewScreenFeature.swift
// AutumnDemo
//
// Created by Sascha, Balkau
//

import Foundation
import Autumn


class WKWebViewScreenFeature : AutumnFeature
{
	override func setup()
	{
		name = "WKWebView Screen Feature"
		descr = "Test scenarios for the demo app WKWebView screen"
		tags = ["WKWebView", "demo"]
	}
	
	
	override func registerScenarios()
	{
		registerScenario(WKWebViewScreenScenario001.self)
	}
}
