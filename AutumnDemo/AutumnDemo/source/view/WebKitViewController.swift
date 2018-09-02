//
// demo-swift
//
// Created by Ciathyza
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
		view.accessibilityIdentifier = DEMO_WKWEBVIEW_VIEW_ACI.id
		webKitView.accessibilityIdentifier = DEMO_WKWEBVIEW_ACI.id
	}
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: - View Logic
	// ------------------------------------------------------------------------------------------------
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: - Handlers
	// ------------------------------------------------------------------------------------------------
	
}
