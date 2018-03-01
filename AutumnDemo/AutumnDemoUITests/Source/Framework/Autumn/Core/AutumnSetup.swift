/*
 * ,---..   .--.--.   .,-.-.,   .
 * |---||   |  |  |   || | ||\  |
 * |   ||   |  |  |   || | || \ |
 * `   '`---'  `  `---'` ' '`  `'
 *  UI Test Automation Framework for Xcode XCTest.
 *  Written by Sascha Balkau.
 */

import Foundation
import XCTest


/**
 * Represents the single test class with single XCUITest test method for use with Autumn.
 * Subclass this class in your project to configure the UI test setup!
 */
open class AutumnSetup : XCTestCase
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Constants
	// ----------------------------------------------------------------------------------------------------
	
	public static let FRAMEWORK_NAME        = "Autumn"
	public static let FRAMEWORK_VERSION     = "0.1.0"
	public static let FRAMEWORK_DESCRIPTION = "UI Automation Framework"
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Singleton Instance
	// ----------------------------------------------------------------------------------------------------
	
	public static let instance = AutumnSetup()
	
	
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
	public var testrailProjectID = ""
	
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
	
	/**
	 * The TestRail feature base URL. This is used for linking to test cases. Is set by default to:
	 * (testrailHost)/index.php?/cases/view/
	 */
	public var testrailFeatureBaseURL = ""
	
	
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
	 * If set to true, the framework will run all tests internally initiated by a single test method.
	 * If false, every test will have to be initiated from its own test method in your AutumnTestSetup
	 * subclass.
	 *
	 * NOTE: Combined mode is currently not supported!
	 */
	public var combinedTestExecutionMode = false
	
	/**
	 * Setting this to true will provide more detailed debug log output.
	 */
	public var debug = false
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public var isTestRailConfigValid:Bool
	{
		return testrailHost.length > 0
			&& testrailFeatureBaseURL.length > 0
			&& testrailTestRunID.length > 0
			&& testrailUsername.length > 0
			&& testrailPassword.length > 0
	}
	
	public private(set) var defaultUserSTG:AutumnUser?
	public private(set) var defaultUserPRD:AutumnUser?
	
	private var _users:[String:AutumnUser] = [:]
	private var _viewProxyClasses:[Metatype<AutumnViewProxy>:AutumnViewProxy] = [:]
	private var _session = AutumnSession()
	
	internal static var app = XCUIApplication()
	internal static var allFeatureClasses:[AutumnFeature.Type] = []
	internal static var allScenarioClasses:[Metatype<AutumnScenario>:AutumnScenario.Type] = [:]
	internal static var allScenarioIDs:[Metatype<AutumnScenario>:String] = [:]
	internal static var isSetupComplete = false
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Abstract Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Used to set all the configuration properties for the project.
	 */
	open func configure()
	{
		/* Abstract method! */
	}
	
	
	/**
	 * Used to register all required test users for the project.
	 */
	open func registerUsers()
	{
		/* Abstract method! */
	}
	
	
	/**
	 * Used to register all required view proxies for the project.
	 */
	open func registerViewProxies()
	{
		/* Abstract method! */
	}
	
	
	/**
	 * Used to register all test features for the project.
	 */
	open func registerFeatures()
	{
		/* Abstract method! */
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Public Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Registers a test user.
	 */
	public func registerUser(_ user:AutumnUser, isDefaultSTG:Bool = false, isDefaultPRD:Bool = false)
	{
		if (_users[user.id] == nil)
		{
			_users[user.id] = user
			_session.stats.testUserTotal += 1
			if isDefaultSTG
			{
				defaultUserSTG = user
				if isStagingBuild && _session.currentTestUser == nil
				{
					_session.currentTestUser = defaultUserSTG
				}
			}
			if isDefaultPRD
			{
				defaultUserPRD = user
				if isStagingBuild && _session.currentTestUser == nil
				{
					_session.currentTestUser = defaultUserPRD
				}
			}
			AutumnLog.debug("Registered user with ID \"\(user.id)\".")
		}
		else
		{
			AutumnLog.notice("User with ID \"\(user.id)\" is already registered.")
		}
	}
	
	
	/**
	 * Returns a specific test user.
	 */
	public func getUser(_ userID:String) -> AutumnUser?
	{
		if (_users[userID] != nil)
		{
			return _users[userID]
		}
		AutumnLog.warning("No user with ID \"\(userID)\" was registered.")
		return nil
	}
	
	
	/**
	 * Registers a view proxy.
	 */
	public func registerViewProxy(_ viewProxyClass:AutumnViewProxy.Type, _ viewName:String = "")
	{
		if (_viewProxyClasses[viewProxyClass.metatype] == nil)
		{
			let viewProxy = viewProxyClass.init(self, viewName)
			_viewProxyClasses[viewProxyClass.metatype] = viewProxy
			_session.stats.viewProxiesTotal += 1
			AutumnLog.debug("Registered view proxy class [\(viewProxyClass)].")
		}
		else
		{
			AutumnLog.notice("View proxy class [\(viewProxyClass)] is already registered.")
		}
	}
	
	
	/**
	 * Returns pre-instantiated view delegate object for the specified view delegate class.
	 */
	public func getViewProxyFor(_ viewProxyClass:AutumnViewProxy.Type) -> AutumnViewProxy?
	{
		if let viewProxy = _viewProxyClasses[viewProxyClass.metatype]
		{
			return viewProxy
		}
		AutumnLog.error("No view proxy registered for class [\(viewProxyClass.metatype)].")
		return nil
	}
	
	
	/**
	 * Registers a test feature.
	 */
	public func registerFeature(_ featureClass:AutumnFeature.Type)
	{
		var featureAlreadyRegistered = false
		for clazz in AutumnSetup.allFeatureClasses
		{
			if clazz.metatype == featureClass.metatype
			{
				featureAlreadyRegistered = true
				break
			}
		}
		
		if !featureAlreadyRegistered
		{
			let feature = featureClass.init(self)
			AutumnSetup.allFeatureClasses.append(featureClass)
			AutumnLog.debug("Registered feature: \"\(feature.name)\".")
		}
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Internal Methods
	// ----------------------------------------------------------------------------------------------------
	
	internal func registerScenarios()
	{
		for featureClass in AutumnSetup.allFeatureClasses
		{
			let feature = featureClass.init(self)
			feature.registerScenarios()
		}
	}
	
	
	/// Removes and returns next feature class.
	///
	internal func dequeueNextFeatureClass() -> AutumnFeature.Type?
	{
		if (AutumnSetup.allFeatureClasses.count > 0)
		{
			_session.currentFeatureIndex += 1
			return AutumnSetup.allFeatureClasses.removeFirst()
		}
		return nil
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - XCTest
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Creates an instance of the testRunClass and passes it as a parameter to -performTest:.
	 */
	override open func run()
	{
		if !AutumnSetup.isSetupComplete
		{
			AutumnLog.info("*** Welcome to \(AutumnSetup.FRAMEWORK_NAME) v\(AutumnSetup.FRAMEWORK_VERSION) ***")
		}
		AutumnLog.debug("Creating testRunClass ...")
		super.run()
	}
	
	
	/**
	 * The method through which tests are executed. Must be overridden by subclasses.
	 */
	override open func perform(_ run:XCTestRun)
	{
		AutumnLog.debug("Performing test run \"\(run.test.name)\" ...")
		super.perform(run)
	}
	
	
	/**
	 * Setup method called before the invocation of each test method in the class.
	 */
	override open func setUp()
	{
		super.setUp()
		continueAfterFailure = true
	}
	
	
	/**
	 * Teardown method called after the invocation of each test method in the class.
	 */
	override open func tearDown()
	{
		if !_session.allowTearDown { return }
		AutumnLog.debug("Tearing down test ...")
		super.tearDown()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Test
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * The first called test method.
	 */
	func test00000000()
	{
		/* Only execute this once! */
		if !AutumnSetup.isSetupComplete
		{
			AutumnLog.debug("Setting up test ...")
			configure()
			
			/* Configure Testrail. */
			testrailFeatureBaseURL = "\(testrailHost)/index.php?/cases/view/"
			
			AutumnLog.debug("Registering objects ...")
			registerUsers()
			registerViewProxies()
			registerFeatures()
			registerScenarios()
			
			AutumnSetup.isSetupComplete = true
			
			AutumnLog.debug("Starting tests in a jiffy ...")
			AutumnUI.sleep(4)
		}
	}
	
	
	/**
	 * The last called test method.
	 */
	func test99999999()
	{
	}
}
