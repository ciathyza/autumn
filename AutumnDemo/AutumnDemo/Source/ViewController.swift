//
//  ViewController.swift
//  AutumnDemo
//
//  Created by Sascha, Balkau | FINAD on 2018/02/27.
//  Copyright © 2018 Ciathyza. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{
	@IBOutlet var loginPromptLabel:UILabel!
	@IBOutlet var usernameInputField:UITextField!
	@IBOutlet var passwordInputField:UITextField!
	@IBOutlet var loginButton:UIButton!
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		view.accessibilityIdentifier = ACI.APP_VIEW.id
		loginPromptLabel.accessibilityIdentifier = ACI.APP_LOGIN_PROMPT_LABEL.id
		usernameInputField.accessibilityIdentifier = ACI.APP_USERNAME_INPUT_FIELD.id
		passwordInputField.accessibilityIdentifier = ACI.APP_PASSWORD_INPUT_FIELD.id
		loginButton.accessibilityIdentifier = ACI.APP_LOGIN_BUTTON.id
		
		self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDismissKeyboard)))
		
	}
	
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}
	
	
	@objc
	func onDismissKeyboard()
	{
		view.endEditing(true)
	}
}
