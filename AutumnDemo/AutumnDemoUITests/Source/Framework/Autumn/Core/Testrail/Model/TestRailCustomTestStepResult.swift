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
 * Represents a TestRail Custom Test Step Result.
 */
struct TestRailCustomTestStepResult : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let statusID:Int
	let content:String
	let expected:String
	let actual:String
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case statusID = "status_id"
		case content  = "content"
		case expected = "expected"
		case actual   = "actual"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { statusID = try values.decode(Int.self,    forKey: .statusID) } catch { statusID = 0 }
		do { content  = try values.decode(String.self, forKey: .content) }  catch { content = "" }
		do { expected = try values.decode(String.self, forKey: .expected) } catch { expected = "" }
		do { actual   = try values.decode(String.self, forKey: .actual) }   catch { actual = "" }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["statusID", "content"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(statusID)", "\(content)"]
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	var hashValue:Int
	{
		return (31 &* statusID.hashValue) &+ content.hashValue &+ expected.hashValue &+ actual.hashValue
	}
	
	
	static func ==(lhs:TestRailCustomTestStepResult, rhs:TestRailCustomTestStepResult) -> Bool
	{
		return lhs.statusID == rhs.statusID
			&& lhs.content == rhs.content
			&& lhs.expected == rhs.expected
			&& lhs.actual == rhs.actual
	}
}
