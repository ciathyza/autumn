//
// AutumnUser.swift
// AutumnFramework
//
// Created by Sascha, Balkau | FINAD on 2018/02/27.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


/**
 * Defines a test user with that you can test user account.
 */
open class AutumnUser
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var id:String
	public var email:String?
	public var password:String
	public var nickname:String?
	public var easyID:String?
	public var nameLast:String?
	public var nameFirst:String?
	public var nameLastKanji:String?
	public var nameFirstKanji:String?
	public var postalCode:String?
	public var addressPrefecture:String?
	public var addressCity:String?
	public var addressResidence:String?
	public var phone1:String?
	public var phone2:String?
	public var phone3:String?
	public var rank:String?
	public var nextMonth:String?
	public var points:String?
	public var birthYear:String?
	public var birthMonth:String?
	public var birthDay:String?
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Initializers
	// ----------------------------------------------------------------------------------------------------
	
	public init(id:String, password:String, nickname:String? = nil)
	{
		self.id = id
		self.password = password
		self.nickname = nickname
	}
	
	
	open func toString() -> String
	{
		return "[AutumnUser id=\(id), password=\(password)]"
	}
}
