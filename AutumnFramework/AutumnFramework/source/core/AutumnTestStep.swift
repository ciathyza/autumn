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
 * Base class for test steps.
 *
 * Test steps can be used in scenario Given/When/Then calls to provide any test logic like
 * executing an action, asserting an element, or simply wait for a while. A test step is
 * synonimic with a TestRail step.
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
	
	public var hashValue:Int { return name.hashValue }
	public var app:XCUIApplication { return AutumnTestRunner.app }
	
	
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
	// MARK: - Helper
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Helper method to convert an NSDictionary ACI to a Swift tuple ACI.
	 */
	public class func getACIFromDict(_ dict:NSDictionary) -> (name:String, id:String)
	{
		var aci = (name: "nil", id: "nil")
		if let d = dict as? [String:String]
		{
			if let id = d["id"]
			{
				aci.id = id
			}
			else
			{
				fatalError("NSDictionary ACI must be of type [String:String] and contain valid name and ID values!")
			}
			if let name = d["name"]
			{
				aci.name = name
			}
			else
			{
				fatalError("NSDictionary ACI must be of type [String:String] and contain valid name and ID values!")
			}
		}
		else
		{
			fatalError("NSDictionary ACI must be of type [String:String]!")
		}
		return aci
	}
	
	
	/**
	 * Helper method to convert a string ACI to a Swift tuple ACI.
	 * The string should contain AutumnStringConstant.STRING_ACI_DELIMITER separating name and id of the element.
	 */
	public class func getACIFromString(_ str:String) -> (name:String, id:String)
	{
		var aci = (name: "nil", id: "nil")
		let components = str.split(AutumnStringConstant.STRING_ACI_DELIMITER)
		if components.count < 1
		{
			fatalError("String ACI must not be empty!")
		}
		else if components.count == 1
		{
			aci.name = components[0]
			aci.id = components[0]
		}
		else
		{
			aci.name = components[0]
			aci.id = components[1]
		}
		
		return aci
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Abstract method! Override and set type, status, and name here.
	 */
	open func setup()
	{
	}
	
	
	/**
	 * Abstract method! Override and execute test instructions here and return the result.
	 */
	open func execute() -> AutumnTestStepResult
	{
		return AutumnTestStepResult()
	}
}


/**
 * Represents a test step with UI interaction that is executed in a test scenario.
 */
open class AutumnUITestStep : AutumnTestStep
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
	 * Initializes the step with an element ACI tuple.
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
	 * Initializes the step with a dictionary. The dictionary must have two keys named "id" and "name".
	 */
	public init(_ dict:NSDictionary, _ elementType:XCUIElement.ElementType = .any)
	{
		let aci = AutumnTestStep.getACIFromDict(dict)
		self.elementID = aci.id
		self.elementName = aci.name
		self.elementType = elementType
		self.element = AutumnUI.getElement(elementID, elementType)
		super.init()
	}
	
	
	/**
	 * Initializes the step with a string. The string should contain a AutumnStringConstant.STRING_ACI_DELIMITER
	 * to separate name and id of the UI element.
	 */
	public init(_ str:String, _ elementType:XCUIElement.ElementType = .any)
	{
		let aci = AutumnTestStep.getACIFromString(str)
		self.elementID = aci.id
		self.elementName = aci.name
		self.elementType = elementType
		self.element = AutumnUI.getElement(elementID, elementType)
		super.init()
	}
	
	
	/**
	 * Initializes the step with a XCUI element.
	 */
	public init(_ element:XCUIElement, _ elementType:XCUIElement.ElementType = .any)
	{
		self.elementID = "\(element.description)"
		self.elementName = "the \(element.description)"
		self.elementType = elementType
		self.element = element
		super.init()
	}
}
