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
class TestRailModel
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Constants
	// ----------------------------------------------------------------------------------------------------
	
	let config:AutumnConfig
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	var projects         = [TestRailProject]()
	var suites           = [TestRailSuite]()
	var milestones       = [TestRailMilestone]()
	var testPlans        = [TestRailTestPlan]()
	var testRuns         = [TestRailTestRun]()
	var testCases        = [TestRailTestCase]()
	var statuses         = [TestRailStatus]()
	var sections         = [TestRailSection]()
	var testCaseFields   = [TestRailTestCaseField]()
	var testCaseTypes    = [TestRailTestCaseType]()
	var templates        = [TestRailTemplate]()
	var tests            = [TestRailTest]()
	var autumnSections   = [TestRailSection]()
	var masterSuiteID    = 0
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Derived Properties
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Returns the root section used for generated test cases or nil if not existing.
	 */
	var rootSection:TestRailSection?
	{
		for s in sections { if s.name == config.testrailRootSectionName { return s } }
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
	 * Returns a section that has the specified name, or nil if no such section exists.
	 */
	func getSection(_ sectionName:String) -> TestRailSection?
	{
		for s in sections
		{
			if s.name == sectionName { return s }
		}
		return nil
	}
	
	
	func getSectionID(_ sectionName:String) -> Int?
	{
		if let section = getSection(sectionName) { return section.id }
		return nil
	}
	
	
	/**
	 * Returns an array of all sections that are children of the Autumn root section.
	 */
	func getAutumnSections() -> [TestRailSection]
	{
		var results = [TestRailSection]()
		if let rootSection = self.rootSection
		{
			getAutumnSectionsRecursive(rootSection, &results)
		}
		return results
	}
	
	
	/**
	 * Returns an array of all section IDs that are children of the Autumn root section.
	 */
	func getAutumnSectionIDs() -> [Int]
	{
		var sections = getAutumnSections()
		var results = [Int]()
		for section in sections
		{
			results.append(section.id)
		}
		return results
	}
	
	
	/**
	 * Recursively find all sections that are under the root section, incl. all child sections.
	 */
	private func getAutumnSectionsRecursive(_ parentSection:TestRailSection, _ results: inout [TestRailSection])
	{
		for section in sections
		{
			if section.parentID == parentSection.id && !results.contains(section)
			{
				results.append(section)
				getAutumnSectionsRecursive(section, &results)
			}
		}
	}
	
	
	/**
	 * Returns a test case with the specified title, or nil if no such test case exists.
	 */
	func getTestCase(_ testCaseTitle:String) -> TestRailTestCase?
	{
		for c in testCases
		{
			if c.title == testCaseTitle { return c }
		}
		return nil
	}
	
	
	/**
	 * Returns the ID of a test case template, or nil.
	 */
	func getTestCaseTemplateIDFor(template:TestRailTestCaseTemplateOption) -> Int?
	{
		for i in templates
		{
			if i.name == template.rawValue { return i.id }
		}
		return nil
	}
	
	
	/**
	 * Returns the ID of a test case type, or nil.
	 */
	func getTestCaseTypeIDFor(type:TestRailTestCaseTypeOption) -> Int?
	{
		for i in testCaseTypes
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
	func addSection(_ section:TestRailSection)
	{
		var i = 0
		for s in sections
		{
			if s.name == section.name { sections.remove(at: i) }
			i += 1
		}
		sections.append(section)
	}
	
	
	/**
	 * Adds a test case. If a test case with the same title already exists it will be replaced.
	 */
	func addTestCase(_ testCase:TestRailTestCase)
	{
		var i = 0
		for c in testCases
		{
			if c.title == testCase.title { testCases.remove(at: i) }
			i += 1
		}
		testCases.append(testCase)
	}
	
	
	func addTestCasesFromFeature(_ feature:AutumnFeature)
	{
		//let featureScenarios =
	}
	
	
	func addTestCaseFromScenario(_ scenario:AutumnScenario, _ feature:AutumnFeature)
	{
		var exists = false
		for c in testCases
		{
			if c.title == scenario.title
			{
				exists = true
				break
			}
		}
		
		if !exists
		{
			var testCase = TestRailTestCase(masterSuiteID, )
			
		}
		
	}
	
	
	/**
	 * Replaces a test case with the same ID. Returns false if no test case with the ID exists.
	 */
	func replaceTestCase(_ testCase:TestRailTestCase) -> Bool
	{
		var success = false
		if let id = testCase.id
		{
			var i = 0
			for c in testCases
			{
				if c.id == id
				{
					testCases.remove(at: i)
					success = true
				}
				i += 1
			}
			if success { testCases.append(testCase) }
		}
		return success
	}
}
