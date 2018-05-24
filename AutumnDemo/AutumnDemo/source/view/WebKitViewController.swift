//
// demo-swift
//
// Created by Sascha Balkau
//

import UIKit
import WebKit


class WebKitViewController : UIViewController, WKNavigationDelegate
{
	// ------------------------------------------------------------------------------------------------
	// MARK: Properties
	// ------------------------------------------------------------------------------------------------
	
	@IBOutlet weak var webKitView: WKWebView!
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: View Controller
	// ------------------------------------------------------------------------------------------------
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		webKitView.navigationDelegate = self
		setupAccessibilityIdentifiers()
		
		let url = URL(string: "https://duckduckgo.com")!
		webKitView.load(URLRequest(url: url))
		webKitView.allowsBackForwardNavigationGestures = true
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
	}
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: - View Logic
	// ------------------------------------------------------------------------------------------------
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: - Handlers
	// ------------------------------------------------------------------------------------------------
	
}
