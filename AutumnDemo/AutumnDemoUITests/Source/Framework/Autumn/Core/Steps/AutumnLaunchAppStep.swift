//
// AutumnLaunchAppStep.swift
// AutumnDemo
//
// Created by Sascha, Balkau | FINAD on 2018/03/07.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


/**
 * A test step that launches the app.
 */
public class AutumnLaunchAppStep : AutumnTestStep
{
	public override func setup()
	{
		type = .Given
		name = "the user has launched the app"
	}
	
	
	public override func execute() -> AutumnTestStepResult
	{
		result.add("Launch App", AutumnUI.launchApp())
		result.add("Is App Running In Foreground", scenario.isAppRunningInForeground)
		return result
	}
}
