//
// WKWebViewScreenScenarios.swift
// AutumnDemo
//
// Created by Sascha, Balkau
//

import Autumn


class WKWebViewScreenScenario001 : AutumnScenario
{
	override func setup()
	{
		id = "WKWVSS001"
		title = "WKWebView Search Engine"
		descr = "Tests the WKWebView by using a search engine."
		clearBrowserData = true
	}
	
	override func establish()
	{
		given(LaunchApp())
		given(EnterTestMenuScreen())
	}
	
	override func execute()
	{
		when(Tap(DEMO_TEST_MENU_SCREEN_BUTTON3_ACI, .button))
		when(WaitForHittable(DEMO_WKWEBVIEW_ACI, .any))
		AutumnLog.dumpViewStructure()
	}
}
