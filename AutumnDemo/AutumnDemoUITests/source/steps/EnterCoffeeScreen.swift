//
// EnterCoffeeScreen.swift
// AutumnDemo
//
// Created by Ciathyza
//

import Foundation
import Autumn


/**
 * Step to enter the coffee screen.
 *
 * This step tries to navigate to the coffee screen,
 * regardless on which screen the user currently is.
 */
class EnterCoffeeScreen : AutumnUITestStep
{
	public init()
	{
		super.init(DEMO_COFFEE_VIEW_ACI, .other)
	}
	
	
	public override func setup()
	{
		name = "\(elementName) is entered"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		/* Currently on Test Menu screen? */
		if let testMenuScreen = AutumnUI.getElement(DEMO_TEST_MENU_SCREEN_VIEW_ACI.id, .any)
		{
			if testMenuScreen.isHittable
			{
				let coffeeScreenButton = AutumnUI.getElement(DEMO_TEST_MENU_SCREEN_BUTTON1_ACI.id, .button)
				result.add("Tap [\(DEMO_TEST_MENU_SCREEN_BUTTON1_ACI.id)]", AutumnUI.tap(coffeeScreenButton))
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
