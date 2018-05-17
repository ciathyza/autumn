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
 * A test step that logs in via the specified login input form and user. If the user is omitted a random
 * user will be picked from all registered users.
 */
public class Login : AutumnTestStep
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	internal var _userNameInputACI:(name:String, id:String)
	internal var _passwordInputACI:(name:String, id:String)
	internal var _loginButtonACI:(name:String, id:String)
	internal var _userNameInput:XCUIElement?
	internal var _passwordInput:XCUIElement?
	internal var _loginButton:XCUIElement?
	internal var _user:AutumnUser
	internal var _isRandomUser = false
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	public init(_ userNameInputACI:(name:String, id:String), _ passwordInputACI:(name:String, id:String), _ loginButtonACI:(name:String, id:String), _ user:AutumnUser? = nil)
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
		
		if let user = user
		{
			_user = user
		}
		else
		{
			_user = AutumnTestRunner.instance.getRandomUser() ?? AutumnTestRunner.instance.getFallbackUser()
			_isRandomUser = true
		}
		
		super.init()
	}
	
	
	public init(_ userNameInputDict:NSDictionary, _ passwordInputDict:NSDictionary, _ loginButtonDict:NSDictionary, _ user:AutumnUser? = nil)
	{
		_userNameInputACI = AutumnTestStep.getACIFromDict(userNameInputDict)
		_passwordInputACI = AutumnTestStep.getACIFromDict(passwordInputDict)
		_loginButtonACI = AutumnTestStep.getACIFromDict(loginButtonDict)
		
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
		
		if let user = user
		{
			_user = user
		}
		else
		{
			_user = AutumnTestRunner.instance.getRandomUser() ?? AutumnTestRunner.instance.getFallbackUser()
			_isRandomUser = true
		}
		
		super.init()
	}
	
	
	public init(_ userNameInputStr:String, _ passwordInputStr:String, _ loginButtonStr:String, _ user:AutumnUser? = nil)
	{
		_userNameInputACI = AutumnTestStep.getACIFromString(userNameInputStr)
		_passwordInputACI = AutumnTestStep.getACIFromString(passwordInputStr)
		_loginButtonACI = AutumnTestStep.getACIFromString(loginButtonStr)
		
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
		
		if let user = user
		{
			_user = user
		}
		else
		{
			_user = AutumnTestRunner.instance.getRandomUser() ?? AutumnTestRunner.instance.getFallbackUser()
			_isRandomUser = true
		}
		
		super.init()
	}
	
	
	public init(_ userNameInput:XCUIElement, _ passwordInput:XCUIElement, _ loginButton:XCUIElement, _ user:AutumnUser? = nil)
	{
		_userNameInputACI = (name: "the \(userNameInput.description)", id: "\(userNameInput.description)")
		_passwordInputACI = (name: "the \(passwordInput.description)", id: "\(passwordInput.description)")
		_loginButtonACI = (name: "the \(loginButton.description)", id: "\(loginButton.description)")
		_userNameInput = userNameInput
		_passwordInput = passwordInput
		_loginButton = loginButton
		
		if let user = user
		{
			_user = user
		}
		else
		{
			_user = AutumnTestRunner.instance.getRandomUser() ?? AutumnTestRunner.instance.getFallbackUser()
			_isRandomUser = true
		}
		
		super.init()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	public override func setup()
	{
		if _isRandomUser
		{
			if name.isEmpty { name = "the user logs-in with a random ID" }
		}
		else
		{
			if name.isEmpty { name = "the user logs-in with ID '\(_user.id)'" }
		}
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
