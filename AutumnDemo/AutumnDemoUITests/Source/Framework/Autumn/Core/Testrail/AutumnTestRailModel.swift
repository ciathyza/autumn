//
// AutumnTestRailModel.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/22.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


struct TestRailCustomTestStepResult : TestRailCodable
{
	let statusID:Int
	let content:String
	let expected:String
	let actual:String
	
	enum CodingKeys : String, CodingKey
	{
		case statusID = "status_id"
		case content  = "content"
		case expected = "expected"
		case actual   = "actual"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { statusID = try values.decode(Int.self,    forKey: .statusID) } catch { statusID = 0 }
		do { content  = try values.decode(String.self, forKey: .content) }  catch { content = "" }
		do { expected = try values.decode(String.self, forKey: .expected) } catch { expected = "" }
		do { actual   = try values.decode(String.self, forKey: .actual) }   catch { actual = "" }
	}
	
	func tableHeader() -> [String]
	{
		return ["statusID", "content"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(statusID)", "\(content)"]
	}
}


// ------------------------------------------------------------------------------------------------
struct TestRailTestResultField : TestRailCodable
{
	let id:Int
	let typeID:Int
	let displayOrder:Int
	let templateIDs:[Int]
	let name:String
	let systemName:String
	let label:String
	let description:String
	let configs:[TestRailConfig]
	let isActive:Bool
	let includeAll:Bool
	
	enum CodingKeys : String, CodingKey
	{
		case id           = "id"
		case typeID       = "type_id"
		case displayOrder = "display_order"
		case templateIDs  = "template_ids"
		case configs      = "configs"
		case name         = "name"
		case systemName   = "system_name"
		case label        = "label"
		case description  = "description"
		case isActive     = "is_active"
		case includeAll   = "include_all"
	}
	
	init(from decoder:Decoder) throws
	{
		let values = try decoder.container(keyedBy: CodingKeys.self)
		do { id           = try values.decode(Int.self,              forKey: .id) }           catch { id = 0 }
		do { typeID       = try values.decode(Int.self,              forKey: .typeID) }       catch { typeID = 0 }
		do { displayOrder = try values.decode(Int.self,              forKey: .displayOrder) } catch { displayOrder = 0 }
		do { templateIDs  = try values.decode([Int].self,            forKey: .templateIDs) }  catch { templateIDs = [Int]() }
		do { name         = try values.decode(String.self,           forKey: .name) }         catch { name = "" }
		do { systemName   = try values.decode(String.self,           forKey: .systemName) }   catch { systemName = "" }
		do { label        = try values.decode(String.self,           forKey: .label) }        catch { label = "" }
		do { description  = try values.decode(String.self,           forKey: .description) }  catch { description = "" }
		do { configs      = try values.decode([TestRailConfig].self, forKey: .configs) }      catch { configs = [TestRailConfig]() }
		do { isActive     = try values.decode(Bool.self,             forKey: .isActive) }     catch { isActive = false }
		do { includeAll   = try values.decode(Bool.self,             forKey: .includeAll) }   catch { includeAll = false }
	}
	
	func tableHeader() -> [String]
	{
		return ["id", "name"]
	}
	
	func toTableRow() -> [String]
	{
		return ["\(id)", "\(name)"]
	}
}
