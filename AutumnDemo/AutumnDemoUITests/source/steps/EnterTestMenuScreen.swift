//
// EnterTestMenuScreen.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/05/14.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation
import Autumn


/**
 * Step to enter the demo test menu screen.
 *
 * This step tries to navigate to the test menu screen,
 * regardless on which screen the user currently is.
 */
class EnterTestMenuScreen : AutumnTestStepAdv
{
	public init()
	{
		super.init(DEMO_TEST_MENU_SCREEN_VIEW_ACI, .any)
	}
	
	
	public override func setup()
	{
		name = "entering \(elementName)"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		if let element = element
		{
			/* Already on test menu screen? */
			if element.isHittable
			{
				result.add("Enter [\(id)]", AutumnUI.assertHittable(element))
			}
			else
			{
				if let coffeView = AutumnUI.getElement(DEMO_COFFEE_VIEW_ACI.id, .any)
				{
					if coffeView.isHittable
					{
						// TODO press back button
					}
				}
			}
		}
		
		return result
	}
}
