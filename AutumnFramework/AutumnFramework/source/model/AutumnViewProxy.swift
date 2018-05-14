/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import Foundation
import XCTest


/**
 * Represents a view proxy for a view that is used for UI testing.
 */
open class AutumnViewProxy : AutumnHashable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Static
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Convenience static computed property to get the wrapped metatype value.
	 */
	public static var metatype:Metatype<AutumnViewProxy>
	{
		return Metatype(self)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public private(set) var app:XCUIApplication
	public private(set) var runner:AutumnTestRunner
	public private(set) var viewName:String
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Initializers
	// ----------------------------------------------------------------------------------------------------
	
	required public init(_ runner:AutumnTestRunner, _ viewName:String = "")
	{
		self.app = AutumnTestRunner.app
		self.runner = runner
		self.viewName = viewName
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	public var hashValue:Int
	{
		return viewName.hashValue
	}
	
	
	public static func ==(lhs:AutumnViewProxy, rhs:AutumnViewProxy) -> Bool
	{
		return lhs.viewName == rhs.viewName
	}
}
