//
//  XCTestRecorder.swift
//  AutumnDemoUITests
//
//  Created by Sascha, Balkau | FINAD on 2018/05/23.
//  Copyright © 2018 Ciathyza. All rights reserved.
//

import XCTest


class XCTestRecorder : XCTestCase
{
	override func setUp()
	{
		super.setUp()
		continueAfterFailure = false
		XCUIApplication().launch()
	}
	
	
	override func tearDown()
	{
		super.tearDown()
	}
	
	
	func testExample()
	{
	}
}
