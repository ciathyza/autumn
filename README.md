# Autumn - UI Automation Framework for XCTest

### What
Autumn is a framework written in Swift around XCTest used for UI Automation on iOS and Mac OS. The framework is specifically designed for use with TestRail so that test cases are defined directly in the test code and test case data as well as test run results are sent and published to TestRail.

Test cases are defined in the code, incl. their readable test instructions for TestRail. When a test is started, Autumn retrieves all required data from the TestRail server, syncs any defined test cases, starts the test run, and submits test results to the server after each test case.

### Framework Source

The Autumn framework in this repository is found under ```AutumnFramework/AutumnFramework/source/```.

The demo app source is found under
```AutumnDemo/AutumnDemo/source``` and the UI test source is found under ```AutumnDemo/AutumnDemoUITests```.

### Get list of iOS Emulator IDs

```
$ xcrun instruments -s devices
```

### Fastlane Test Invocation

```
$ bundle exec fastlane scan --workspace "autumn.xcworkspace" --scheme "UI Tests (STG)" --device "iPhone 8 (11.2)" --clean --include_simulator_log true || true
```

(Won't show framework log output in console.)

### Xcode Test Invocation

```
$ xcodebuild -workspace autumn.xcworkspace/ -scheme 'UI Tests (STG)' -destination 'platform=iOS Simulator,id=7E42917B-AC3F-4CE3-87DF-4371E1D63DAB' clean build test
```

(Show framework log output in console.)

### Hierarchy

Autumn follows a hierarchy similar to Calabash, therefore tests can be constructed from the following elements (smallest to largest):

  - **Instruction**: represents a single instruction in a test step. For example a command to wait for 5 seconds, or to tap a button. Instructions have to return true or false.
  - **Step**: Steps are reusable classes that are added in the **Given/When/Then** stages in scenarios. A step can contain one or more instructions. **Given** is used to establish preconditions for a test case, **When** is used to invoke an action (tap, wait, swipe, see, etc.), **Then** is used to evaluate the result of a **When** step.
  - **Scenario**: Comparable to a Test Case on TestRail, a scenario is defined in its own class and contains one or more test steps.
  - **Feature**: Comparable to a Section on TestRail, a feature contains one or more scenarios.

Another important building block are **View Proxies**. A view proxy class acts as a wrapper for a specific view (often, but not necessarily, a screen). Reusable code to interact with the view can be defined in a view proxy.

### Execution Concept

  1. **Configuration**: The framework configures the test session according to parameters specified by the user.
  2. **Data Retrieval**: All required data for the test session is retrieved from the TestRail server (project, suite, sections, test cases, test runs, etc.).
  3. Registers all locally defined features and scenarios.
  4. **Data Sync**: Locally defined test features and test scenarios are compared with any existing TestRail sections and test cases. Any sections and/or test cases are updated on TestRail to be in sync with local data.
  5. **Test Execution**: The framework executes all test scenarios in the order in that they were registered. Scenario results are submitted to the server every time a scenario completed.
  6. **Test Completion**: After all scenarios have been executed, the test session is closed and final results are shown.

### How-To

#### Installation & Setup

1. Create a new Xcode workspace.
2. Create a new Xcode project, add it to the workspace.
3. When creating the project ensure `Create UI Tests` is checked.
4. Init the workspace with `$ pod init`.
5. Add the following line to the UI test target in your Podfile:

```
pod 'Autumn', :git => 'https://git.rakuten-it.com/scm/~ts-balkau.sascha/autumn.git', :tag => '1.0.0'
```

Podfile example:

```
workspace 'autumntest.xcworkspace'
platform :ios, '10.0'

target 'AutumnTest' do
	project 'AutumnTest/AutumnTest.xcodeproj'
	use_frameworks!
	inherit! :search_paths

	target 'AutumnTestUITests' do
		use_frameworks!
		inherit! :search_paths
		pod 'Autumn', :git => 'https://git.rakuten-it.com/scm/~ts-balkau.sascha/autumn.git', :tag => '1.0.0'
	end
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['ENABLE_BITCODE'] = 'NO'
		end
	end
end
```

6. Run `$ pod install`.
7. Change the `YourAppUITests.swift` class in your Xcode UI tests target to extend from `AutumnTestRunner` and override the required methods:

```
import Autumn

class AutumnTestUITests : AutumnTestRunner
{
	override func configure()
	{
	}
	
	override func registerUsers()
	{
	}
	
	override func registerViewProxies()
	{
	}
	
	override func registerFeatures()
	{
	}
}
```

8. Register any test users in ```registerUsers()```.
9. Create features by sub-classing ```AutumnFeature``` and register them in ```registerFeatures()```.
10. Create scenarios for the features by sub-classing ```AutumnScenario```. Register them in ```registerScenarios()``` of the respective feature class you've defined before.
11. Create necessary step classes by sub-classing ```AutumnTestStep```, or re-use factory step classes.
13. Use the steps (and pre-defined steps) in your scenario classes by executing them with ```given()```, ```when()```, and ```then()```.

Please check the included demo source code to understand how test scenarios are written.
