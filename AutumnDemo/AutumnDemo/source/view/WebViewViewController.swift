//
// demo-swift
//
// Created by Sascha Balkau
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
	}
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: - View Logic
	// ------------------------------------------------------------------------------------------------
	
	
	// ------------------------------------------------------------------------------------------------
	// MARK: - Handlers
	// ------------------------------------------------------------------------------------------------
	
}
