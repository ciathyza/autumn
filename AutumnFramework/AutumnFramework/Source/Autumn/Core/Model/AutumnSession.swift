//
// AutumnSession.swift
// AutumnFramework
//
// Created by Sascha, Balkau | FINAD on 2018/02/27.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


/**
 * Represents a test session run by Autumn.
 */
internal class AutumnSession
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Internal Methods
	// ----------------------------------------------------------------------------------------------------
	
	internal var stats = AutumnStats()
	
	public internal(set) var currentTestUser:AutumnUser?
	public internal(set) var currentFeature:AutumnFeature?
	public internal(set) var currentScenario:AutumnScenario?
	public internal(set) var currentFeatureIndex:UInt = 0
	public internal(set) var currentScenarioIndex:UInt = 0
	public internal(set) var loginAttemptCount:UInt = 0
	public internal(set) var allowTearDown = false
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
}
