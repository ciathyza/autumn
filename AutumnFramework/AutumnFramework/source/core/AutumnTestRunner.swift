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
	public static let FRAMEWORK_VERSION     = "1.0.3"
	public static let FRAMEWORK_DESCRIPTION = "UI Automation Framework"
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Singleton Instance
	// ----------------------------------------------------------------------------------------------------
	
	public private(set) static var instance:AutumnTestRunner!
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public let config = AutumnConfig()
	
	internal private(set) var session = AutumnSession()
	internal private(set) var model:AutumnModel!
	
	private var _testrailClient:AutumnTestRailClient!
	private let _fallbackUser = AutumnUser("fallbackUser", "NONE", "Fallback User")
	
	internal static let app = XCUIApplication()
	internal static var isTestCalledOnce = false
	internal static var isLocalMode = false
	internal static var phase = AutumnPhase.Init
	
	
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
		if (model.users[user.id] == nil)
		{
			model.users[user.id] = user
			session.stats.testUserTotal += 1
			if isDefaultSTG
			{
				session.defaultUserSTG = user
				if config.isStagingBuild && session.currentTestUser == nil
				{
					session.currentTestUser = session.defaultUserSTG
				}
			}
			if isDefaultPRD
			{
				session.defaultUserPRD = user
				if config.isStagingBuild && session.currentTestUser == nil
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
		if model.users[userID] != nil
		{
			return model.users[userID]
		}
		AutumnLog.warning("No user with ID \"\(userID)\" was registered.")
		return nil
	}
	
	
	/**
	 * Returns a random test user.
	 */
	public func getRandomUser() -> AutumnUser?
	{
		if model.users.count < 1 { return nil }
		let i = Int(arc4random_uniform(UInt32(model.users.count)))
		let v = Array(model.users.values)[i]
		return v
	}
	
	
	/**
	 * Returns a fallback test user.
	 */
	public func getFallbackUser() -> AutumnUser
	{
		return _fallbackUser
	}
	
	
	/**
	 * Registers a view proxy.
	 */
	public func registerViewProxy(_ viewProxyClass:AutumnViewProxy.Type, _ viewName:String = "")
	{
		if (model.viewProxyClasses[viewProxyClass.metatype] == nil)
		{
			let viewProxy = viewProxyClass.init(self, viewName)
			model.viewProxyClasses[viewProxyClass.metatype] = viewProxy
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
		if let viewProxy = model.viewProxyClasses[viewProxyClass.metatype]
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
		let feature = featureClass.init(self)
		if !model.features.containsObject(feature)
		{
			feature.setup()
			if feature.descr.length < 1
			{
				AutumnLog.warning("Feature \"\(feature.name)\" has no description and will be skipped!")
			}
			else
			{
				if model.hasFeatureWithName(feature.name)
				{
					AutumnLog.warning("Ignoring feature \"\(feature.name)\" that has the same name as another feature. Feature names must be unique!")
				}
				else
				{
					model.features.append(feature)
					AutumnLog.debug("Registered feature: \"\(feature.name)\".")
				}
			}
		}
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Internal/Private Methods
	// ----------------------------------------------------------------------------------------------------
	
	internal func submitTestResult(_ scenario:AutumnScenario)
	{
		_testrailClient.submitTestResult(scenario)
	}
	
	
	internal func isTestResultSubmitComplete() -> Bool
	{
		return _testrailClient.isTestRailSubmissionComplete
	}
	
	
	private func configureTestSession() -> Bool
	{
		AutumnTestRunner.phase = .Configuration
		AutumnLog.debug("Configuring test session ...")
		
		model = AutumnModel(config)
		_testrailClient = AutumnTestRailClient(config, model)
		session.initialize(self)
		configure()
		
		if config.debug
		{
			AutumnLog.debug("\n\(config.dumpTable())")
		}
		
		if !config.isConfigValid
		{
			AutumnLog.notice("Configuration is missing required settings. Aborting!")
			return false
		}
		if !config.isTestRailConfigValid
		{
			AutumnLog.notice("Configuration is missing required TestRail settings. The framework will run in local test mode!")
			AutumnTestRunner.isLocalMode = true
		}
		
		return true
	}
	
	
	private func retrieveTestRailData() -> Bool
	{
		if AutumnTestRunner.isLocalMode { return true }
		
		AutumnTestRunner.phase = .DataRetrieval
		AutumnLog.debug("Retrieving TestRail data ...")
		_testrailClient.retrieveTestRailData()
		
		if !model.isTestRailDataValid()
		{
			AutumnLog.notice("TestRail data is invalid. Aborting!")
			return false
		}
		
		return true
	}
	
	
	private func registerLocalTestData() -> Bool
	{
		AutumnTestRunner.phase = .DataRegistration
		AutumnLog.debug("Registering local test data ...")
		
		registerUsers()
		registerViewProxies()
		registerFeatures()
		
		for feature in model.features
		{
			feature.registerScenarios()
		}
		
		session.stats.testUserTotal = model.users.count
		session.stats.viewProxiesTotal = model.viewProxyClasses.count
		session.stats.featuresTotal = model.features.count
		
		AutumnLog.debug("Registered \(model.users.count) users.")
		AutumnLog.debug("Registered \(model.viewProxyClasses.count) view proxy classes.")
		AutumnLog.debug("Registered \(model.features.count) features.")
		
		if !model.isDataValid()
		{
			AutumnLog.notice("No test features and/or scenarios have been registered. Aborting!")
			return false
		}
		
		return true
	}
	
	
	private func syncTestRailData() -> Bool
	{
		if AutumnTestRunner.isLocalMode { return true }
		
		AutumnTestRunner.phase = .DataSync
		AutumnLog.debug("Syncing data to TestRail ...")
		_testrailClient.syncData()
		return true
	}
	
	
	private func startTestSession()
	{
		AutumnLog.debug(session.stats.getSetupStats())
		
		AutumnTestRunner.phase = .TestExecution
		AutumnLog.debug("Starting tests in a jiffy ...")
		AutumnUI.sleep(4)
		session.start()
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - XCTest
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Creates an instance of the testRunClass and passes it as a parameter to -performTest:.
	 */
	override open func run()
	{
		if !AutumnTestRunner.isTestCalledOnce
		{
			AutumnTestRunner.instance = self
			/* Enable logging to file. */
			Log.logFilePath = AutumnLog.LOGFILE_OUTPUT_PATH
			AutumnLog.info("*** Welcome to \(AutumnTestRunner.FRAMEWORK_NAME) v\(AutumnTestRunner.FRAMEWORK_VERSION) ***")
			let df = DateFormatter()
			df.dateFormat = "HH:mm:ss, EEEE, MMM d, yyyy"
			AutumnLog.info("The time is \(df.string(from: Date()))")
			
			AutumnLog.debug("Creating testRunClass ...")
			super.run()
		}
	}
	
	
	/**
	 * The method through which tests are executed. Must be overridden by subclasses.
	 */
	override open func perform(_ run:XCTestRun)
	{
		if !AutumnTestRunner.isTestCalledOnce
		{
			AutumnLog.debug("Performing test run \"\(run.test.name)\" ...")
			super.perform(run)
		}
	}
	
	
	/**
	 * Setup method called before the invocation of each test method in the class.
	 */
	override open func setUp()
	{
		if !AutumnTestRunner.isTestCalledOnce
		{
			AutumnLog.debug("Setting up test ...")
			super.setUp()
			continueAfterFailure = true
		}
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
	final func test()
	{
		/* Ensure this only gets called once! */
		if !AutumnTestRunner.isTestCalledOnce
		{
			AutumnTestRunner.isTestCalledOnce = true
			
			if !configureTestSession() { return }
			if !retrieveTestRailData() { return }
			if !registerLocalTestData() { return }
			if !syncTestRailData() { return }
			
			startTestSession()
		}
	}
}
