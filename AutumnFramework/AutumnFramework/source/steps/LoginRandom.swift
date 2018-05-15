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
 * A test step that logs in via the specified login input form and a randomly chosen user.
 */
public class LoginRandom : AutumnTestStep
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	internal var _userNameInputACI:(name:String, id:String)
	internal var _passwordInputACI:(name:String, id:String)
	internal var _userNameInput:XCUIElement?
	internal var _passwordInput:XCUIElement?
	internal var _loginButtonACI:(name:String, id:String)
	internal var _loginButton:XCUIElement?
	internal var _user:AutumnUser
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------

	public init(_ userNameInputACI:(name:String, id:String), _ passwordInputACI:(name:String, id:String), _ loginButtonACI:(name:String, id:String))
	{
		_userNameInputACI = userNameInputACI
		_passwordInputACI = passwordInputACI
		_loginButtonACI = loginButtonACI
		_userNameInput = AutumnUI.getElement(_userNameInputACI.id, .textField)
		_passwordInput = AutumnUI.getElement(_passwordInputACI.id, .secureTextField)
		if _passwordInput == nil
		{
			_passwordInput = AutumnUI.getElement(_passwordInputACI.id, .textField)
			if _passwordInput != nil
			{
				AutumnLog.warning("Password input field \"\(_passwordInputACI.id)\" is not a secure text field.")
			}
		}
		_loginButton = AutumnUI.getElement(_loginButtonACI.id, .button)
		_user = AutumnTestRunner.instance.getRandomUser() ?? AutumnTestRunner.instance.getFallbackUser()
		super.init()
	}
	
	
	public init(_ userNameInput:XCUIElement, _ passwordInput:XCUIElement, _ loginButton:XCUIElement)
	{
		_userNameInputACI = (name: "the \(userNameInput.description)", id: "\(userNameInput.description)")
		_passwordInputACI = (name: "the \(passwordInput.description)", id: "\(passwordInput.description)")
		_loginButtonACI = (name: "the \(loginButton.description)", id: "\(loginButton.description)")
		_userNameInput = userNameInput
		_passwordInput = passwordInput
		_loginButton = loginButton
		_user = AutumnTestRunner.instance.getRandomUser() ?? AutumnTestRunner.instance.getFallbackUser()
		super.init()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public override func setup()
	{
		name = "the user logs-in with a random ID"
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
