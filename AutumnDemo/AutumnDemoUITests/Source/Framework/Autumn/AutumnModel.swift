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
 * Main model for all TestRail data that is fetched from and send to the TestRail server.
 */
class AutumnModel
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Constants
	// ----------------------------------------------------------------------------------------------------
	
	let config:AutumnConfig
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	var features                   = [AutumnFeature]()
	var scenarioClasses            = [Metatype<AutumnScenario>:AutumnScenario.Type]()
	var scenarioIDs                = [Metatype<AutumnScenario>:String]()
	var viewProxyClasses           = [Metatype<AutumnViewProxy>:AutumnViewProxy]()
	var users                      = [String:AutumnUser]()
	
	var testrailProjects           = [TestRailProject]()
	var testrailSuites             = [TestRailSuite]()
	var testrailMilestones         = [TestRailMilestone]()
	var testrailPlans              = [TestRailTestPlan]()
	var testrailRuns               = [TestRailTestRun]()
	var testrailCases              = [TestRailTestCase]()
	var testrailStatuses           = [TestRailStatus]()
	var testrailSections           = [TestRailSection]()
	var testrailCaseFields         = [TestRailTestCaseField]()
	var testrailCaseTypes          = [TestRailTestCaseType]()
	var testrailTemplates          = [TestRailTemplate]()
	var testrailTests              = [TestRailTest]()
	var testrailAutomationSections = [TestRailSection]()
	var testrailMasterSuiteID      = 0
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Derived Properties
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Returns the root section used for generated test cases or nil if not existing.
	 */
	var rootSection:TestRailSection?
	{
		for s in testrailSections { if s.name == config.testrailRootSectionName { return s } }
		return nil
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Init
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Init with ref to config.
	 */
	init(_ config:AutumnConfig)
	{
		self.config = config
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Query Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Determines whether the testrail data is valid.
	 */
	func isTestRailDataValid() -> Bool
	{
		return testrailProjects.count > 0
			&& testrailSuites.count > 0
	}
	
	
	/**
	 * Returns a TestRail section that has the specified name, or nil if no such section exists.
	 */
	func getTestRailSection(_ sectionName:String) -> TestRailSection?
	{
		for s in testrailSections
		{
			if s.name == sectionName { return s }
		}
		return nil
	}
	
	
	/**
	 * Returns the ID of the TestRail section that has the specified name,
	 * or nil if no such section exists.
	 */
	func getTestRailSectionID(_ sectionName:String) -> Int?
	{
		if let section = getTestRailSection(sectionName) { return section.id }
		return nil
	}
	
	
	/**
	 * Returns an array of all sections that are children of the Autumn root section.
	 */
	func getTestRailAutomationSections() -> [TestRailSection]
	{
		var results = [TestRailSection]()
		if let rootSection = self.rootSection
		{
			getTestRailAutomationSectionsRecursive(rootSection, &results)
		}
		return results
	}
	
	
	/**
	 * Returns an array of all TestRail section IDs that are children of the automation root section.
	 */
	func getTestRailAutomationSectionIDs() -> [Int]
	{
		var sections = getTestRailAutomationSections()
		var results = [Int]()
		for section in sections
		{
			results.append(section.id)
		}
		return results
	}
	
	
	/**
	 * Returns a test case with the specified title, or nil if no such test case exists.
	 */
	func getTestRailCase(_ testCaseTitle:String) -> TestRailTestCase?
	{
		for c in testrailCases
		{
			if c.title == testCaseTitle { return c }
		}
		return nil
	}
	
	
	/**
	 * Returns the ID of a test case template, or nil.
	 */
	func getTestRailCaseTemplateIDFor(template:TestRailTestCaseTemplateOption) -> Int?
	{
		for i in testrailTemplates
		{
			if i.name == template.rawValue { return i.id }
		}
		return nil
	}
	
	
	/**
	 * Returns the ID of a test case type, or nil.
	 */
	func getTestRailCaseTypeIDFor(type:TestRailTestCaseTypeOption) -> Int?
	{
		for i in testrailCaseTypes
		{
			if i.name == type.rawValue { return i.id }
		}
		return nil
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Moditication Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Adds a section. If a section with the same name already exists it will be replaced.
	 */
	func addTestRailSection(_ section:TestRailSection)
	{
		var i = 0
		for s in testrailSections
		{
			if s.name == section.name { testrailSections.remove(at: i) }
			i += 1
		}
		testrailSections.append(section)
	}
	
	
	/**
	 * Adds a test case. If a test case with the same title already exists it will be replaced.
	 */
	func addTestRailCase(_ testCase:TestRailTestCase)
	{
		var i = 0
		for c in testrailCases
		{
			if c.title == testCase.title { testrailCases.remove(at: i) }
			i += 1
		}
		testrailCases.append(testCase)
	}
	
	
	func addTestRailCasesFromFeature(_ feature:AutumnFeature)
	{
		//let featureScenarios =
	}
	
	
	func addTestRailCaseFromScenario(_ scenario:AutumnScenario, _ feature:AutumnFeature)
	{
		var exists = false
		for c in testrailCases
		{
			if c.title == scenario.title
			{
				exists = true
				break
			}
		}
		
		if !exists
		{
			//var testCase = TestRailTestCase(masterSuiteID, )
			
		}
		
	}
	
	
	/**
	 * Replaces a test case with the same ID. Returns false if no test case with the ID exists.
	 */
	func replaceTestRailCase(_ testCase:TestRailTestCase) -> Bool
	{
		var success = false
		if let id = testCase.id
		{
			var i = 0
			for c in testrailCases
			{
				if c.id == id
				{
					testrailCases.remove(at: i)
					success = true
				}
				i += 1
			}
			if success { testrailCases.append(testCase) }
		}
		return success
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Private Methods
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Recursively find all sections that are under the root section, incl. all child sections.
	 */
	private func getTestRailAutomationSectionsRecursive(_ parentSection:TestRailSection, _ results: inout [TestRailSection])
	{
		for section in testrailSections
		{
			if section.parentID == parentSection.id && !results.contains(section)
			{
				results.append(section)
				getTestRailAutomationSectionsRecursive(section, &results)
			}
		}
	}
}
