//
//  ViewController.swift
//  AutumnDemo
//
//  Created by Sascha, Balkau | FINAD on 2018/02/27.
//  Copyright © 2018 Ciathyza. All rights reserved.
//

import UIKit


class MoreStuffViewController : UIViewController
{
	
	@IBOutlet var moreStuffLabel: UILabel!
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		view.accessibilityIdentifier = ACI.APP_MORE_STUFF_VIEW.id
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
