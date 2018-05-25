/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import Foundation


/**
 * Defines a user used for logging into an app.
 */
open class AutumnUser : AutumnHashable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var id:String
	public var password:String
	public var type = AutumnServerType.STG
	public var email:String?
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
	
	public init(_ id:String, _ password:String, _ nickname:String? = nil, _ type:AutumnServerType = .STG)
	{
		self.id = id
		self.password = password
		self.nickname = nickname
		self.type = type
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	public var hashValue:Int
	{
		return id.hashValue
	}
	
	
	public static func ==(lhs:AutumnUser, rhs:AutumnUser) -> Bool
	{
		return lhs.id == rhs.id && lhs.password == rhs.password
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Public Methods
	// ----------------------------------------------------------------------------------------------------
	
	open func toString() -> String
	{
		return "[AutumnUser id=\(id), password=\(password)]"
	}
}
