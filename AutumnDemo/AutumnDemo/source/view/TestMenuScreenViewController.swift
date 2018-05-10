//
//  TestMenuScreenViewController.swift
//  demo-swift
//
//  Created by Sascha Balkau
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
		view.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_VIEW_ACI.id
		button1.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_BUTTON1_ACI.id
		button2.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_BUTTON2_ACI.id
		button3.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_BUTTON3_ACI.id
		button4.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_BUTTON4_ACI.id
		button5.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_BUTTON5_ACI.id
		resetButton.accessibilityIdentifier = DEMO_TEST_MENU_SCREEN_RESET_BUTTON_ACI.id
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
			case DEMO_TEST_MENU_SCREEN_BUTTON1_ACI.id:
				return
			case DEMO_TEST_MENU_SCREEN_BUTTON2_ACI.id:
				return
			case DEMO_TEST_MENU_SCREEN_BUTTON3_ACI.id:
				return
			case DEMO_TEST_MENU_SCREEN_BUTTON4_ACI.id:
				return
			case DEMO_TEST_MENU_SCREEN_BUTTON5_ACI.id:
				return
			case DEMO_TEST_MENU_SCREEN_RESET_BUTTON_ACI.id:
				resetApp()
			default:
				print("No option for \(buttonID)!")
		}
	}
}
