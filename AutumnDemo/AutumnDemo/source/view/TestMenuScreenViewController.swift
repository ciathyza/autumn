//
//  TestMenuScreenViewController.swift
//  demo-swift
//
//  Created by Sascha, Balkau | FINAD on 2017/09/29.
//  Copyright © 2017 Rakuten. All rights reserved.
//

import UIKit


class TestMenuScreenViewController : UIViewController
{
	// ------------------------------------------------------------------------------------------------
	// MARK: Properties
	// ------------------------------------------------------------------------------------------------
	
	@IBOutlet var button1:UIButton!
	@IBOutlet var button2:UIButton!
	@IBOutlet var button3:UIButton!
	@IBOutlet var button4:UIButton!
	@IBOutlet var button5:UIButton!
	@IBOutlet var resetButton:UIButton!
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: View Controller
	// ------------------------------------------------------------------------------------------------
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setupAccessibilityIdentifiers()
	}
	
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}


	// ------------------------------------------------------------------------------------------------
	// MARK: - Setup
	// ------------------------------------------------------------------------------------------------
	
	func setupAccessibilityIdentifiers()
	{
		view.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_VIEW_ACI
		button1.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_BUTTON1_ACI
		button2.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_BUTTON2_ACI
		button3.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_BUTTON3_ACI
		button4.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_BUTTON4_ACI
		button5.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_BUTTON5_ACI
		resetButton.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_RESET_BUTTON_ACI
	}
	
	
	func resetApp()
	{
	}


	// ------------------------------------------------------------------------------------------------
	// MARK: - Handlers
	// ------------------------------------------------------------------------------------------------
	
	@IBAction func onButtonTap(_ sender:UIButton)
	{
		let buttonID = sender.accessibilityIdentifier!
		switch buttonID
		{
			case DEMO_TEST_MENU_SCREEN_BUTTON1_ACI:
				return
			case DEMO_TEST_MENU_SCREEN_BUTTON2_ACI:
				return
			case DEMO_TEST_MENU_SCREEN_BUTTON3_ACI:
				return
			case DEMO_TEST_MENU_SCREEN_BUTTON4_ACI:
				return
			case DEMO_TEST_MENU_SCREEN_BUTTON5_ACI:
				return
			case DEMO_TEST_MENU_SCREEN_RESET_BUTTON_ACI:
				resetApp()
			default:
				print("No option for \(buttonID)!")
		}
	}
}
