//
// EnterTestMenuScreen.swift
// AutumnDemo
//
// Created by Sascha Balkau
//

import Foundation
import Autumn


/**
 * Step to enter the demo test menu screen.
 *
 * This step tries to navigate to the test menu screen,
 * regardless on which screen the user currently is.
 */
class EnterTestMenuScreen : AutumnUITestStep
{
	public init()
	{
		super.init(DEMO_TEST_MENU_SCREEN_VIEW_ACI, .other)
	}
	
	
	public override func setup()
	{
		name = "\(elementName) is entered"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		/* Currently on Coffee screen? */
		if let coffeeScreen = AutumnUI.getElement(DEMO_COFFEE_VIEW_ACI.id, .any)
		{
			if coffeeScreen.isHittable
			{
				result.add("Tap [\(DEMO_COFFEE_VIEW_ACI.id)] navigation bar back button", AutumnUI.tap(app.navigationBars["Obtain Coffee"].buttons["Back"]))
			}
		}
		
		if let element = element
		{
			if element.isHittable
			{
				result.add("Enter [\(id)]", AutumnUI.assertHittable(element))
			}
		}
		
		return result
	}
}
