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
open class AutumnTestRunner : XCTestCase
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
	
	public static let instance = AutumnTestRunner()
	
	
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
	
	internal var session = AutumnSession()
	private var _users:[String:AutumnUser] = [:]
	private var _viewProxyClasses:[Metatype<AutumnViewProxy>:AutumnViewProxy] = [:]
	
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
			session.stats.testUserTotal += 1
			if isDefaultSTG
			{
				session.defaultUserSTG = user
				if isStagingBuild && session.currentTestUser == nil
				{
					session.currentTestUser = session.defaultUserSTG
				}
			}
			if isDefaultPRD
			{
				session.defaultUserPRD = user
				if isStagingBuild && session.currentTestUser == nil
				{
					session.currentTestUser = session.defaultUserPRD
				}
			}
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
			session.stats.viewProxiesTotal += 1
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
		for clazz in AutumnTestRunner.allFeatureClasses
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
			AutumnTestRunner.allFeatureClasses.append(featureClass)
			AutumnLog.debug("Registered feature: \"\(feature.name)\".")
		}
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Internal Methods
	// ----------------------------------------------------------------------------------------------------
	
	internal func registerScenarios()
	{
		for featureClass in AutumnTestRunner.allFeatureClasses
		{
			let feature = featureClass.init(self)
			feature.registerScenarios()
		}
	}
	
	
	/// Removes and returns next feature class.
	///
	internal func dequeueNextFeatureClass() -> AutumnFeature.Type?
	{
		if (AutumnTestRunner.allFeatureClasses.count > 0)
		{
			session.currentFeatureIndex += 1
			return AutumnTestRunner.allFeatureClasses.removeFirst()
		}
		return nil
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Private Methods
	// ----------------------------------------------------------------------------------------------------
	
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - XCTest
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Creates an instance of the testRunClass and passes it as a parameter to -performTest:.
	 */
	override open func run()
	{
		if !AutumnTestRunner.isSetupComplete
		{
			AutumnLog.info("*** Welcome to \(AutumnTestRunner.FRAMEWORK_NAME) v\(AutumnTestRunner.FRAMEWORK_VERSION) ***")
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
		AutumnLog.debug("Setting up test ...")
		super.setUp()
		continueAfterFailure = true
	}
	
	
	/**
	 * Teardown method called after the invocation of each test method in the class.
	 */
	override open func tearDown()
	{
		if !session.allowTearDown { return }
		AutumnLog.debug("Tearing down test ...")
		super.tearDown()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Test
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * This method gets called automatically by XCTest. Normally we'd have to put every test case into
	 * a dedicated test method but we want Autumn to control the flow of test case execution therefore
	 * we initiate test case launches from within this single test method.
	 */
	func test()
	{
		/* Only execute this once! */
		if !AutumnTestRunner.isSetupComplete
		{
			AutumnLog.debug("Setting up test session ...")
			configure()
			
			/* Configure Testrail. */
			testrailFeatureBaseURL = "\(testrailHost)/index.php?/cases/view/"
			
			AutumnLog.debug("Registering objects ...")
			registerUsers()
			registerViewProxies()
			registerFeatures()
			registerScenarios()
			
			AutumnLog.debug("Registered \(_users.count) users.")
			AutumnLog.debug("Registered \(_viewProxyClasses.count) view proxy classes.")
			AutumnLog.debug("Registered \(AutumnTestRunner.allFeatureClasses.count) feature classes.")
			
			session.initialize(self)
			AutumnTestRunner.isSetupComplete = true
			
			AutumnLog.debug("Starting tests in a jiffy ...")
			AutumnUI.sleep(4)
		}
		
		session.start()
		session.end()
	}
}
