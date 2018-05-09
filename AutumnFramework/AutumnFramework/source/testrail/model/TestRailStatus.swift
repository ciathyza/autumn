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
 * Represents a TestRail Status.
 */
struct TestRailStatus : TestRailCodable
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	let id:Int
	let name:String
	let label:String
	let colorDark:Int
	let colorMedium:Int
	let colorBright:Int
	let isSystem:Bool
	let isUntested:Bool
	let isFinal:Bool
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Enums
	// ----------------------------------------------------------------------------------------------------
	
	enum CodingKeys : String, CodingKey
	{
		case id          = "id"
		case name        = "name"
		case label       = "label"
		case colorDark   = "color_dark"
		case colorMedium = "color_medium"
		case colorBright = "color_bright"
		case isSystem    = "is_system"
		case isUntested  = "is_untested"
		case isFinal     = "is_final"
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	init(from decoder:Decoder) throws
	{
		let values  = try decoder.container(keyedBy: CodingKeys.self)
		do { id          = try values.decode(Int.self,    forKey: .id) }          catch { id = 0 }
		do { name        = try values.decode(String.self, forKey: .name) }        catch { name = "" }
		do { label       = try values.decode(String.self, forKey: .label) }       catch { label = "" }
		do { colorDark   = try values.decode(Int.self,    forKey: .colorDark) }   catch { colorDark = 0 }
		do { colorMedium = try values.decode(Int.self,    forKey: .colorMedium) } catch { colorMedium = 0 }
		do { colorBright = try values.decode(Int.self,    forKey: .colorBright) } catch { colorBright = 0 }
		do { isSystem    = try values.decode(Bool.self,   forKey: .isSystem) }    catch { isSystem = false }
		do { isUntested  = try values.decode(Bool.self,   forKey: .isUntested) }  catch { isUntested = false }
		do { isFinal     = try values.decode(Bool.self,   forKey: .isFinal) }     catch { isFinal = false }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
	func tableHeader() -> [String]
	{
		return ["ID", "Name", "Label", "Hash"]
	}
	
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)", "\(label)", "\(hashValue)"]
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Hashable & Equatable
	// ----------------------------------------------------------------------------------------------------
	
	var hashValue:Int
	{
		return id.hashValue
	}
	
	
	static func ==(lhs:TestRailStatus, rhs:TestRailStatus) -> Bool
	{
		return lhs.id == rhs.id
			&& lhs.name == rhs.name
			&& lhs.label == rhs.label
			&& lhs.colorDark == rhs.colorDark
			&& lhs.colorMedium == rhs.colorMedium
			&& lhs.colorBright == rhs.colorBright
			&& lhs.isSystem == rhs.isSystem
			&& lhs.isUntested == rhs.isUntested
			&& lhs.isFinal == rhs.isFinal
	}
}
