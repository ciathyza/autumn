//
// AutumnEnums.swift
// AutumnFramework
//
// Created by Sascha, Balkau | FINAD on 2018/02/27.
// Copyright (c) 2018 Ciathyza. All rights reserved.
//

import Foundation


public enum AutumnPlatform : String
{
	case Android = "Android"
	case iOS     = "iOS"
}

public enum AutumnTestStatus : String
{
	case Normal      = "Normal"
	case Pending     = "Pending"
	case Unsupported = "Unsupported"
	case Started     = "Started"
	case Failed      = "Failed"
	case Passed      = "Passed"
}

public enum AutumnStepType : String
{
	case None  = "None"
	case Given = "Given"
	case When  = "When"
	case Then  = "Then"
}

public enum AutumnRecordType : String
{
	case Activate       = "Activate"
	case Assert         = "Assert"
	case BeginFeature   = "BeginFeature"
	case BeginScenario  = "BeginScenario"
	case BeginStep      = "BeginStep"
	case EndFeature     = "EndFeature"
	case EndScenario    = "EndScenario"
	case Enter          = "Enter"
	case IgnoreScenario = "IgnoreScenario"
	case Kill           = "Kill"
	case Launch         = "Launch"
	case Log            = "Log"
	case LogSession     = "LogSession"
	case Mark           = "Mark"
	case SetUser        = "SetUser"
	case StepGiven      = "StepGiven"
	case StepThen       = "StepThen"
	case StepWhen       = "StepWhen"
	case Terminate      = "Terminate"
	case UIAction       = "UIAction"
	case Uninstall      = "Uninstall"
	case Wait           = "Wait"
}

public enum AutumnWaitType : String
{
	case Wait               = "Wait"
	case WaitForExists      = "WaitForExists"
	case WaitForHittable    = "WaitForHittable"
	case WaitForIsTrue      = "WaitForIsTrue"
	case WaitForNotExists   = "WaitForNotExists"
	case WaitForNotHittable = "WaitForNotHittable"
	case Timeout            = "Timeout"
}

public enum AutumnUIActionType : String
{
	case Tap         = "Tap"
	case TapOptional = "TapOptional"
	case TypeText    = "TypeText"
	case SwipeLeft   = "SwipeLeft"
	case SwipeRight  = "SwipeRight"
	case SwipeDown   = "SwipeDown"
	case SwipeUp     = "SwipeUp"
	case Failed      = "Failed"
}

public enum AutumnTestRailResultStatusID : Int
{
	case Passed      = 1
	case Blocked     = 2
	case Untested    = 3
	case Retest      = 4
	case Failed      = 5
	case FixInFuture = 6
	case ScopeOut    = 7
	case Pending     = 8
	case CannotTest  = 9
}

public enum AutumnUnsupportedReason : String
{
	case None                                 = "N/A"
	case RequiresAppStoreVersion              = "Requires Appstore version"
	case RequiresAppTaskKill                  = "Requires app task kill"
	case RequiresExternalAuthentication       = "Requires external authentication (e.g. SMS)"
	case RequiresExternalDataCheck            = "Requires external data check (e.g. analytics data)"
	case RequiresExternalLogin                = "Requires external login"
	case RequiresExternalScanning             = "Requires external scanning (e.g. Barcode scanner)"
	case RequiresHardwareDevice               = "Requires hardware device"
	case RequiresManualUpdate                 = "Requires manual update"
	case RequiresOldAppVersion                = "Requires old app version"
	case RequiresProxy                        = "Requires proxy"
	case RequiresServerSideConfiguration      = "Requires server-side configuration"
	case RequiresSIMOperation                 = "Requires SIM operation"
	case RequiresSpecificDeviceModel          = "Requires specific device model"
	case RequiresSpecificLocation             = "Requires to be in a specific location"
	case RequiresSpecificLocationServiceState = "Requires specific location service state"
	case RequiresSpecificServerSideData       = "Requires specific server side data"
	case RequiresSpecificServerSideStatus     = "Requires specific server side status (e.g. maintenance, error)"
	case RequiresThirdPartyAppInstall         = "Requires third-party app install"
	case UnreachableAppUIState                = "Unreachable app UI state"
}
