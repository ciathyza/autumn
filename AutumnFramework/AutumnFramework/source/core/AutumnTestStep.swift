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
 * Represents a test step that is executed in a test scenario.
 */
open class AutumnTestStep : Hashable, Equatable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var type = AutumnStepType.None
	public var status = AutumnTestStatus.Normal
	public var name = ""
	
	open private(set) var result = AutumnTestStepResult()
	internal var phase = AutumnScenarioPhase.None
	internal var scenario:AutumnScenario!
	
	public var hashValue:Int
	{
		return name.hashValue
	}
	
	public var app:XCUIApplication
	{
		return AutumnTestRunner.app
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	public init()
	{
		setup()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Equatable
	// ----------------------------------------------------------------------------------------------------
	
	public static func ==(lhs:AutumnTestStep, rhs:AutumnTestStep) -> Bool
	{
		return lhs.hashValue == rhs.hashValue
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Abstract method! Override and set type, status, and name here!
	 */
	open func setup()
	{
	}
	
	
	/**
	 * Abstract method! Override and execute test instructions here and return the result!
	 */
	open func execute() -> AutumnTestStepResult
	{
		return AutumnTestStepResult()
	}
}


/**
 * Represents a test step with UI interaction that is executed in a test scenario.
 */
open class AutumnTestStepAdv : AutumnTestStep
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public internal(set) var elementID:String
	public internal(set) var elementName:String
	public internal(set) var elementType:XCUIElement.ElementType
	public internal(set) var element:XCUIElement?
	
	public var id:String
	{
		return "\(AutumnUI.getElementTypeName(elementType)).\(elementID)"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Init with element ACI.
	 */
	public init(_ aci:(name:String, id:String), _ elementType:XCUIElement.ElementType = .any)
	{
		self.elementID = aci.id
		self.elementName = aci.name
		self.elementType = elementType
		self.element = AutumnUI.getElement(elementID, elementType)
		super.init()
	}
	
	
	/**
	 * Init with element.
	 */
	public init(_ element:XCUIElement, _ elementType:XCUIElement.ElementType = .any)
	{
		self.elementID = "\(element.description)"
		self.elementName = "\(element.description)"
		self.elementType = elementType
		self.element = element
		super.init()
	}
}
