//
// GetCoffeeViewController.swift
// demo-swift
//
// Created by Sascha, Balkau | FINAD on 2017/10/02.
// Copyright (c) 2017 Rakuten. All rights reserved.
//

import UIKit


class GetCoffeeViewController: UIViewController
{
	// ------------------------------------------------------------------------------------------------
	// MARK: Properties
	// ------------------------------------------------------------------------------------------------
	
	@IBOutlet var loginPromptLabel:UILabel!
	@IBOutlet var usernameInput:UITextField!
	@IBOutlet var passwordInput:UITextField!
	@IBOutlet var loginButton:UIButton!
	@IBOutlet var coffeeStrengthLabel:UILabel!
	@IBOutlet var coffeeStrengthSelector:UISegmentedControl!
	@IBOutlet var sugarLabel:UILabel!
	@IBOutlet var sugarSlider:UISlider!
	@IBOutlet var whipCreamLabel:UILabel!
	@IBOutlet var whipCreamSwitch:UISwitch!
	@IBOutlet var extraCaffeineLabel:UILabel!
	@IBOutlet var extraCaffeineValueLabel:UILabel!
	@IBOutlet var extraCaffeineStepper:UIStepper!
	@IBOutlet var brewButton:UIButton!
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: View Controller
	// ------------------------------------------------------------------------------------------------
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setupAccessibilityIdentifiers()
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onViewTap(_:)))
		tapGestureRecognizer.cancelsTouchesInView = false
		view.addGestureRecognizer(tapGestureRecognizer)
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
		view.accessibilityIdentifier = DEMO_COFFEE_VIEW_ACI
		loginPromptLabel.accessibilityIdentifier = DEMO_COFFEE_LOGIN_PROMPT_ACI
		usernameInput.accessibilityIdentifier = DEMO_COFFEE_USERNAME_INPUT_ACI
		passwordInput.accessibilityIdentifier = DEMO_COFFEE_PASSWORD_INPUT_ACI
		loginButton.accessibilityIdentifier = DEMO_COFFEE_LOGIN_BUTTON_ACI
		coffeeStrengthLabel.accessibilityIdentifier = DEMO_COFFEE_STRENGTH_LABEL_ACI
		coffeeStrengthSelector.accessibilityIdentifier = DEMO_COFFEE_STRENGTH_SELECTOR_ACI
		sugarLabel.accessibilityIdentifier = DEMO_COFFEE_SUGAR_LABEL_ACI
		sugarSlider.accessibilityIdentifier = DEMO_COFFEE_SUGAR_SLIDER_ACI
		whipCreamLabel.accessibilityIdentifier = DEMO_COFFEE_WHIPCREAM_LABEL_ACI
		whipCreamSwitch.accessibilityIdentifier = DEMO_COFFEE_WHIPCREAM_SWITCH_ACI
		extraCaffeineLabel.accessibilityIdentifier = DEMO_COFFEE_EXTRA_CAFFEINE_LABEL_ACI
		extraCaffeineValueLabel.accessibilityIdentifier = DEMO_COFFEE_EXTRA_CAFFEINE_VALUE_LABEL_ACI
		extraCaffeineStepper.accessibilityIdentifier = DEMO_COFFEE_EXTRA_CAFFEINE_STEPPER_ACI
		brewButton.accessibilityIdentifier = DEMO_COFFEE_BREW_BUTTON_ACI
	}
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: - View Logic
	// ------------------------------------------------------------------------------------------------
	
	func showAlert(title:String, message:String)
	{
		let localizedTitle = NSLocalizedString(title, comment: "")
		let localizedMessage = NSLocalizedString(message, comment: "")
		let alertController = UIAlertController(title: localizedTitle, message: localizedMessage, preferredStyle: .alert)
		let action = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler:
		{ (alert) in
		})
		alertController.addAction(action)
		present(alertController, animated: true, completion: nil)
	}
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: - Handlers
	// ------------------------------------------------------------------------------------------------
	
	@objc func onViewTap(_ recognizer:UIGestureRecognizer)
	{
		usernameInput.resignFirstResponder()
		passwordInput.resignFirstResponder()
	}
	
	
	@IBAction func onLoginButtonTap(_ sender:UIButton)
	{
		if let username = usernameInput.text, let password = passwordInput.text
		{
			if (username.count > 0 && password.count > 0)
			{
				showAlert(title: "Logged-in!", message: "You have logged in with username \"\(username)\".")
			}
			else
			{
				showAlert(title: "Not logged-in!", message: "Please enter login data.")
			}
		}
	}
	
	
	@IBAction func onCoffeeStrengthValueChanged(_ sender:UISegmentedControl)
	{
	}
	
	
	@IBAction func onSugarAmountChanged(_ sender:UISlider)
	{
	}
	
	
	@IBAction func onWhipCreamToggle(_ sender:UISwitch)
	{
	}
	
	
	@IBAction func onExtraCaffeineValueChanged(_ sender:UIStepper)
	{
		extraCaffeineValueLabel.text = "\(Int(extraCaffeineStepper.value))mg"
	}
	
	
	@IBAction func onBrewButtonTap(_ sender:UIButton)
	{
	}
}
