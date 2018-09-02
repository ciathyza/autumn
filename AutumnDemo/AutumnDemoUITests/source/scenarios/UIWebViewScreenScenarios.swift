//
// UIWebViewScreenScenarios.swift
// AutumnDemo
//
// Created by Ciathyza
//

import Autumn


class UIWebViewScreenScenario001 : AutumnScenario
{
	override func setup()
	{
		id = "UIWVSS001"
		title = "UIWebView Search Engine"
		descr = "Tests the UIWebView by using a search engine."
		clearBrowserData = true
	}
	
	override func establish()
	{
		given(LaunchApp())
	}
	
	override func execute()
	{
		when(Tap(DEMO_TEST_MENU_SCREEN_BUTTON2_ACI, .button))
		then(AssertExists(DEMO_UIWEBVIEW_VIEW_ACI, .other))
		
		let searchInput = app.webViews.otherElements["DuckDuckGo — Privacy, simplified."].children(matching: .textField).element
		when(WaitForHittable(searchInput))
		when(Tap(searchInput))
		when(TypeText(searchInput, "Rakuten"))
		when(Tap(app.webViews.buttons["S"]))
		then(WaitForHittable(app.webViews.children(matching: .other).element))
	}
}
