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


// ------------------------------------------------------------------------------------------------

/**
 * A test step that launches the app.
 */
public class LaunchApp : AutumnTestStep
{
	public override func setup()
	{
		name = "the user has launched the app"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Launch App", AutumnUI.launchApp())
		result.add("Is App Running In Foreground", AutumnUI.isAppRunningInForeground)
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that let's the app wait for X seconds.
 */
public class Wait : AutumnTestStep
{
	private var _seconds:UInt = 0
	
	public init(_ seconds:UInt)
	{
		_seconds = seconds
		super.init()
	}
	
	public override func setup()
	{
		name = "the user waits for \(_seconds) seconds"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Wait \(_seconds) Seconds", AutumnUI.wait(_seconds))
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that waits for a given UI element to exist.
 */
public class WaitForExists : AutumnTestStepAdv
{
	private var _timeout:UInt = 0
	
	public init(_ aci:(name:String, id:String), _ elementType:XCUIElement.ElementType = .any, _ timeout:UInt = 0)
	{
		_timeout = timeout > 0 ? timeout : AutumnTestRunner.instance.config.viewPresentTimeout
		super.init(aci, elementType)
	}
	
	public override func setup()
	{
		name = "\(elementName) exists within \(_timeout) seconds"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Wait for [\(id)] to exist within \(_timeout) seconds", AutumnUI.waitForExists(element, timeout: _timeout))
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that waits for a given UI element to become hittable.
 */
public class WaitForHittable : AutumnTestStepAdv
{
	private var _timeout:UInt = 0
	
	public init(_ aci:(name:String, id:String), _ elementType:XCUIElement.ElementType = .any, _ timeout:UInt = 0)
	{
		_timeout = timeout > 0 ? timeout : AutumnTestRunner.instance.config.viewPresentTimeout
		super.init(aci, elementType)
	}
	
	public override func setup()
	{
		name = "\(elementName) becomes hittable within \(_timeout) seconds"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Wait for [\(id)] to be hittable within \(_timeout) seconds", AutumnUI.waitForHittable(element, timeout: _timeout))
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that taps a given UI element.
 */
public class Tap : AutumnTestStepAdv
{
	public override init(_ aci:(name:String, id:String), _ elementType:XCUIElement.ElementType = .any)
	{
		super.init(aci, elementType)
	}
	
	public override func setup()
	{
		name = "the user taps \(elementName)"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(id)]", AutumnUI.tap(element))
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that types text into a given UI input field.
 */
public class TypeText : AutumnTestStepAdv
{
	internal var _text:String
	
	public init(_ aci:(name:String, id:String), _ text:String, _ elementType:XCUIElement.ElementType = .textField)
	{
		_text = text
		super.init(aci, elementType)
	}
	
	public override func setup()
	{
		name = "the user enters '\(_text)' into \(elementName)"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(id)]", AutumnUI.tap(element))
		result.add("Tap [\(id) clear button] if available", AutumnUI.tapOptional(element?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		result.add("Enter '\(_text)' into [\(id)]", AutumnUI.typeText(element, text: _text))
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that types a password into a given UI input field.
 */
public class TypePassword : TypeText
{
	public override init(_ aci:(name:String, id:String), _ text:String, _ elementType:XCUIElement.ElementType = .secureTextField)
	{
		super.init(aci, text, elementType)
	}
	
	public override func setup()
	{
		name = "the user enters '\(_text.obscured)' into \(elementName)"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(id)]", AutumnUI.tap(element))
		result.add("Tap [\(id) clear button] if available", AutumnUI.tapOptional(element?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		result.add("Enter '\(_text.obscured)' into [\(id)]", AutumnUI.typeText(element, text: _text))
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that logs in with a given input form and user.
 */
public class Login : AutumnTestStep
{
	internal var _userNameInputACI:(name:String, id:String)
	internal var _passwordInputACI:(name:String, id:String)
	internal var _userNameInput:XCUIElement?
	internal var _passwordInput:XCUIElement?
	internal var _loginButtonACI:(name:String, id:String)
	internal var _loginButton:XCUIElement?
	internal var _user:AutumnUser
	
	public init(_ userNameInputACI:(name:String, id:String), _ passwordInputACI:(name:String, id:String), _ loginButtonACI:(name:String, id:String), _ user:AutumnUser)
	{
		_userNameInputACI = userNameInputACI
		_passwordInputACI = passwordInputACI
		_loginButtonACI = loginButtonACI
		_userNameInput = AutumnUI.getElement(_userNameInputACI.id, .textField)
		_passwordInput = AutumnUI.getElement(_passwordInputACI.id, .secureTextField)
		_loginButton = AutumnUI.getElement(_loginButtonACI.id, .button)
		_user = user
		super.init()
	}
	
	public override func setup()
	{
		name = "the user logs-in with ID '\(_user.id)'"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(_userNameInputACI.id)]", AutumnUI.tap(_userNameInput))
		result.add("Tap [\(_userNameInputACI.id) clear button] if available", AutumnUI.tapOptional(_userNameInput?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		result.add("Enter '\(_user.id)' into [\(_userNameInputACI.id)]", AutumnUI.typeText(_userNameInput, text: _user.id))
		result.add("Tap [\(_passwordInputACI.id)]", AutumnUI.tap(_passwordInput))
		result.add("Tap [\(_passwordInputACI.id) clear button] if available", AutumnUI.tapOptional(_passwordInput?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		result.add("Enter '\(_user.password.obscured)' into [\(_passwordInputACI.id)]", AutumnUI.typeText(_passwordInput, text: _user.password))
		result.add("Tap [\(_loginButtonACI.id)]", AutumnUI.tap(_loginButton))
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that logs in with a given input form and a random user.
 */
public class LoginRandom : AutumnTestStep
{
	internal var _userNameInputACI:(name:String, id:String)
	internal var _passwordInputACI:(name:String, id:String)
	internal var _userNameInput:XCUIElement?
	internal var _passwordInput:XCUIElement?
	internal var _loginButtonACI:(name:String, id:String)
	internal var _loginButton:XCUIElement?
	internal var _user:AutumnUser
	
	public init(_ userNameInputACI:(name:String, id:String), _ passwordInputACI:(name:String, id:String), _ loginButtonACI:(name:String, id:String))
	{
		_userNameInputACI = userNameInputACI
		_passwordInputACI = passwordInputACI
		_loginButtonACI = loginButtonACI
		_userNameInput = AutumnUI.getElement(_userNameInputACI.id, .textField)
		_passwordInput = AutumnUI.getElement(_passwordInputACI.id, .secureTextField)
		_loginButton = AutumnUI.getElement(_loginButtonACI.id, .button)
		_user = AutumnTestRunner.instance.getRandomUser() ?? AutumnTestRunner.instance.getFallbackUser()
		super.init()
	}
	
	public override func setup()
	{
		name = "the user logs-in with ID '\(_user.id)'"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(_userNameInputACI.id)]", AutumnUI.tap(_userNameInput))
		result.add("Tap [\(_userNameInputACI.id) clear button] if available", AutumnUI.tapOptional(_userNameInput?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		result.add("Enter '\(_user.id)' into [\(_userNameInputACI.id)]", AutumnUI.typeText(_userNameInput, text: _user.id))
		result.add("Tap [\(_passwordInputACI.id)]", AutumnUI.tap(_passwordInput))
		result.add("Tap [\(_passwordInputACI.id) clear button] if available", AutumnUI.tapOptional(_passwordInput?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		result.add("Enter '\(_user.password.obscured)' into [\(_passwordInputACI.id)]", AutumnUI.typeText(_passwordInput, text: _user.password))
		result.add("Tap [\(_loginButtonACI.id)]", AutumnUI.tap(_loginButton))
		return result
	}
}

// ------------------------------------------------------------------------------------------------

/**
 * A test step that clears a given UI input field.
 */
public class ClearInputField : AutumnTestStepAdv
{
	public init(_ aci:(name:String, id:String))
	{
		super.init(aci, .textField)
	}
	
	public override func setup()
	{
		name = "the user clears \(elementName)"
	}
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Tap [\(id)]", AutumnUI.tap(element))
		result.add("Tap [\(id) clear button] if available", AutumnUI.tapOptional(element?.buttons[AutumnStringConstant.TEXTFIELD_CLEAR_BUTTON]))
		return result
	}
}
