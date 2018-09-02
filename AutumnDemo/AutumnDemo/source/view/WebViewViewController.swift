//
// demo-swift
//
// Created by Ciathyza
//

import UIKit


class WebViewViewController : UIViewController, UIWebViewDelegate
{
	// ------------------------------------------------------------------------------------------------
	// MARK: Properties
	// ------------------------------------------------------------------------------------------------
	
	
	@IBOutlet weak var webView: UIWebView!
	
	// ------------------------------------------------------------------------------------------------
	// MARK: View Controller
	// ------------------------------------------------------------------------------------------------
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		webView.delegate = self
		
		setupAccessibilityIdentifiers()
		
		let url = URL(string: "https://duckduckgo.com")!
		let request = URLRequest(url: url)
		webView.loadRequest(request)
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
		view.accessibilityIdentifier = DEMO_UIWEBVIEW_VIEW_ACI.id
		webView.accessibilityIdentifier = DEMO_UIWEBVIEW_ACI.id
	}
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: - View Logic
	// ------------------------------------------------------------------------------------------------
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: - Handlers
	// ------------------------------------------------------------------------------------------------
	
}
