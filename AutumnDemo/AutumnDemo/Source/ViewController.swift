//
//  ViewController.swift
//  AutumnDemo
//
//  Created by Sascha, Balkau | FINAD on 2018/02/27.
//  Copyright © 2018 Ciathyza. All rights reserved.
//

import UIKit


class ViewController : UIViewController
{
	@IBOutlet var titleText:UILabel!
	@IBOutlet var testButton:UIButton!
	@IBOutlet var inputField:UITextField!
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		view.accessibilityIdentifier = ACI.APP_VIEW.id
		titleText.accessibilityIdentifier = ACI.APP_TITLE_TEXT.id
		testButton.accessibilityIdentifier = ACI.APP_TEST_BUTTON.id
		inputField.accessibilityIdentifier = ACI.APP_INPUT_FIELD.id
	}
	
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}
}
