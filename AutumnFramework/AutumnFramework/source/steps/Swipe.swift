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
 * A test step that swipes the specified UI element in a specific direction.
 */
public class Swipe : AutumnUITestStep
{
	private var _direction = AutumnUI.SwipeDirection.Left
	
	
	public init(_ aci:(name:String, id:String), _ direction:AutumnUI.SwipeDirection, _ elementType:XCUIElement.ElementType = .any)
	{
		_direction = direction
		super.init(aci, elementType)
	}
	
	
	public init(_ element:XCUIElement, _ direction:AutumnUI.SwipeDirection, _ elementType:XCUIElement.ElementType = .any)
	{
		_direction = direction
		super.init(element, elementType)
	}
	
	
	public override func setup()
	{
		if name.isEmpty { name = "\(elementName) is swiped \(_direction.rawValue)" }
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Swipe [\(id)] \(_direction.rawValue)", AutumnUI.swipe(element, _direction))
		return result
	}
}
