//
// AutumnSessionManager.swift
// AutumnFramework
//
// Created by Sascha, Balkau | FINAD on 2018/02/27.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation
import XCTest


/// Manages all book-keeping tasks of Autumn by recording intermediate test data and results.
/// Also provides support for TestRail integration and JSON report generation.
class AutumnSessionManager
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Singleton Instance
	// ----------------------------------------------------------------------------------------------------
	
	static let instance = AutumnSessionManager()
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Recording API
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Records a test session action.
	 */
	public func record(type:AutumnRecordType, args:Any...)
	{
	}
}
