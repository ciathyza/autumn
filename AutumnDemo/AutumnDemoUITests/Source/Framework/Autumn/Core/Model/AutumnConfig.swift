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
 * Stores all configuration properties.
 */
public class AutumnConfig : NSObject
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Project Config Properties
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * The name of the project that is being tested.
	 */
	public var projectName = ""
	
	/**
	 * The name of the app as it appears for the app icon.
	 */
	public var appName = ""
	
	/**
	 * The ID of the app.
	 */
	public var appID = ""
	
	/**
	 * Path to optionally used test account CSV file.
	 */
	public var testUserAccountsCSVFileURL = ""
	
	/**
	 * Needs to set to STG from app if this is a STG build.
	 */
	public var isStagingBuild = false
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - TestRail Config Properties
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * The TestRail host URL for the project, e.g. https://yourproject.testrail.net
	 */
	public var testrailHost = ""
	
	/**
	 * The TestRail username used for logging into TestRail.
	 */
	public var testrailUsername = ""
	
	/**
	 * The TestRail user password (or API key) used for logging into TestRail.
	 */
	public var testrailPassword = ""
	
	/**
	 * The nummeric TestRail project ID, e.g. 4
	 */
	public var testrailProjectID = 0
	
	/**
	 * The ID of the TestRail test run used to submit test results, e.g. 562
	 */
	public var testrailTestRunID = ""
	
	/**
	 * Platform IDs used by TestRail to distinguish between Android and iOS test cases.
	 */
	public var testrailOSIDs = [AutumnPlatform.Android.rawValue: 1, AutumnPlatform.iOS.rawValue: 2]
	
	/**
	 * The current used test platform.
	 */
	public var testrailPlatform = AutumnPlatform.iOS
	
	/**
	 * The ID used by TestRail to identify test cases that cannot be automated.
	 */
	public var testrailCannotAutomateID = 2
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Framework Config Properties
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Time in seconds used to slow down test execution. Disabled if 0.
	 */
	public var slowSeconds:UInt = 0
	
	/**
	 * How many seconds to wait for a view to be present.
	 */
	public var viewPresentTimeout:UInt = 5
	
	/**
	 * How many seconds to wait for a view to be ready for user interaction.
	 */
	public var viewReadyTimeout:UInt = 15
	
	/**
	 * How many seconds to wait before a pending network request is considered failed.
	 */
	public var networkRequestTimeout:UInt = 10
	
	/**
	 * How many seconds to wait before a pending network request is considered failed.
	 */
	public var networkLoginTimeout:UInt = 20
	
	/**
	 * How many times to retry a failed login before considered failed.
	 */
	public var maxLoginAttempts:UInt = 4
	
	/**
	 * How many seconds to wait between failed login attempts.
	 */
	public var loginAttemptsDelay:UInt = 2
	
	/**
	 * How many times to retry a failed scenario before considered failed.
	 */
	public var maxScenarioRetries:UInt = 1
	
	/**
	 * If set to false instructions will not be included in log output.
	 */
	public var logInstructions = true
	
	/**
	 * Setting this to true will provide more detailed debug log output.
	 */
	public var debug = false
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Derrived Properties
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * The TestRail feature base URL. This is used for linking to test cases. Is set by default to:
	 * (testrailHost)/index.php?/cases/view/
	 */
	public var testrailFeatureBaseURL:String
	{
		return "\(testrailHost)/index.php?/cases/view/"
	}
	
	
	public var isTestRailConfigValid:Bool
	{
		return testrailHost.length > 0
				&& testrailFeatureBaseURL.length > 0
				&& testrailTestRunID.length > 0
				&& testrailUsername.length > 0
				&& testrailPassword.length > 0
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Methods
	// ----------------------------------------------------------------------------------------------------
	
}
