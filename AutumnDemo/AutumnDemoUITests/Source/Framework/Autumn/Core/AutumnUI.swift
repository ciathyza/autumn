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
 * Delegation methods for XCUITest UI interaction, waiting, and asserts.
 */
public class AutumnUI
{
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Properties
	// ----------------------------------------------------------------------------------------------------
	
	public static let elementTypeValues =
	[
		XCUIElement.ElementType.activityIndicator,
		XCUIElement.ElementType.alert,
		XCUIElement.ElementType.application,
		XCUIElement.ElementType.browser,
		XCUIElement.ElementType.button,
		XCUIElement.ElementType.cell,
		XCUIElement.ElementType.checkBox,
		XCUIElement.ElementType.collectionView,
		XCUIElement.ElementType.colorWell,
		XCUIElement.ElementType.comboBox,
		XCUIElement.ElementType.datePicker,
		XCUIElement.ElementType.decrementArrow,
		XCUIElement.ElementType.dialog,
		XCUIElement.ElementType.disclosureTriangle,
		XCUIElement.ElementType.dockItem,
		XCUIElement.ElementType.drawer,
		XCUIElement.ElementType.grid,
		XCUIElement.ElementType.group,
		XCUIElement.ElementType.handle,
		XCUIElement.ElementType.helpTag,
		XCUIElement.ElementType.icon,
		XCUIElement.ElementType.image,
		XCUIElement.ElementType.incrementArrow,
		XCUIElement.ElementType.key,
		XCUIElement.ElementType.keyboard,
		XCUIElement.ElementType.layoutArea,
		XCUIElement.ElementType.layoutItem,
		XCUIElement.ElementType.levelIndicator,
		XCUIElement.ElementType.link,
		XCUIElement.ElementType.map,
		XCUIElement.ElementType.matte,
		XCUIElement.ElementType.menu,
		XCUIElement.ElementType.menuBar,
		XCUIElement.ElementType.menuBarItem,
		XCUIElement.ElementType.menuButton,
		XCUIElement.ElementType.menuItem,
		XCUIElement.ElementType.navigationBar,
		XCUIElement.ElementType.other,
		XCUIElement.ElementType.outline,
		XCUIElement.ElementType.outlineRow,
		XCUIElement.ElementType.pageIndicator,
		XCUIElement.ElementType.picker,
		XCUIElement.ElementType.pickerWheel,
		XCUIElement.ElementType.popover,
		XCUIElement.ElementType.popUpButton,
		XCUIElement.ElementType.progressIndicator,
		XCUIElement.ElementType.radioButton,
		XCUIElement.ElementType.radioGroup,
		XCUIElement.ElementType.ratingIndicator,
		XCUIElement.ElementType.relevanceIndicator,
		XCUIElement.ElementType.ruler,
		XCUIElement.ElementType.rulerMarker,
		XCUIElement.ElementType.scrollBar,
		XCUIElement.ElementType.scrollView,
		XCUIElement.ElementType.searchField,
		XCUIElement.ElementType.secureTextField,
		XCUIElement.ElementType.segmentedControl,
		XCUIElement.ElementType.sheet,
		XCUIElement.ElementType.slider,
		XCUIElement.ElementType.splitGroup,
		XCUIElement.ElementType.splitter,
		XCUIElement.ElementType.staticText,
		XCUIElement.ElementType.statusBar,
		XCUIElement.ElementType.statusItem,
		XCUIElement.ElementType.stepper,
		XCUIElement.ElementType.switch,
		XCUIElement.ElementType.tab,
		XCUIElement.ElementType.tabBar,
		XCUIElement.ElementType.tabGroup,
		XCUIElement.ElementType.table,
		XCUIElement.ElementType.tableColumn,
		XCUIElement.ElementType.tableRow,
		XCUIElement.ElementType.textField,
		XCUIElement.ElementType.textView,
		XCUIElement.ElementType.timeline,
		XCUIElement.ElementType.toggle,
		XCUIElement.ElementType.toolbar,
		XCUIElement.ElementType.toolbarButton,
		XCUIElement.ElementType.touchBar,
		XCUIElement.ElementType.valueIndicator,
		XCUIElement.ElementType.webView,
		XCUIElement.ElementType.window
	]
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - App
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Launches the app to running in foreground state.
	 */
	public class func launchApp(_ app:XCUIApplication? = nil) -> Bool
	{
		if let app = app
		{
			app.launchArguments = ["--uitesting", "-StartFromCleanState", "YES"]
			app.launch()
			return app.state == .runningForeground
		}
		AutumnTestRunner.app.launchArguments = ["--uitesting", "-StartFromCleanState", "YES"]
		AutumnTestRunner.app.launch()
		return AutumnTestRunner.app.state == .runningForeground
	}
	
	
	/**
	 * Launches the app to running in foreground state.
	 */
	public class func activateApp(_ app:XCUIApplication? = nil) -> Bool
	{
		if let app = app
		{
			app.activate()
			return app.state == .runningForeground
		}
		AutumnTestRunner.app.activate()
		return AutumnTestRunner.app.state == .runningForeground
	}
	
	
	/**
	 * Terminates the app.
	 */
	public class func terminateApp(_ app:XCUIApplication? = nil) -> Bool
	{
		if let app = app
		{
			app.terminate()
			return app.state == .notRunning
		}
		AutumnTestRunner.app.terminate()
		return AutumnTestRunner.app.state == .notRunning
	}
	
	
	/**
	 * Task-kills the app.
	 */
	public class func killApp(_ app:XCUIApplication? = nil) -> Bool
	{
		if let app = app
		{
			return Springboard.killApp(app: app)
		}
		return Springboard.killApp(app: AutumnTestRunner.app)
	}
	
	
	/**
	 * Uninstalls the app.
	 */
	public class func uninstallApp(_ app:XCUIApplication? = nil) -> Bool
	{
		if let app = app
		{
			return Springboard.uninstallApp(app: app)
		}
		return Springboard.uninstallApp(app: AutumnTestRunner.app)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Wait
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Same as wait() method but without logging.
	 *
	 * @param interval The time to wait in seconds.
	 */
	public class func sleep(_ interval:UInt)
	{
		Darwin.sleep(UInt32(interval))
	}
	
	
	/**
	 * Waits for x seconds.
	 *
	 * @param interval The time to wait in seconds.
	 */
	public class func wait(_ interval:UInt) -> Bool
	{
		return Darwin.sleep(UInt32(interval)) >= 0
	}
	
	
	/**
	 * Wait for an element to exist and be hittable (visible and onscreen).
	 *
	 * @param element Element to wait for.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was hittable within time limit, otherwise false.
	 */
	public class func waitForHittable(_ element:XCUIElement, timeout:UInt = 0) -> Bool
	{
		let clause = "hittable == true"
		let timeout = timeout == 0 ? AutumnTestRunner.instance.config.viewPresentTimeout : timeout
		let success = AutumnUI.waitFor(element, clause: clause, timeout: timeout)
		return success
	}
	
	
	/**
	 * Wait until an element is no longer hittable (might still exist, but is either not visible
	 * or not onscreen).
	 *
	 * @param element Element to wait for.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was hittable within time limit, otherwise false.
	 */
	public class func waitForNotHittable(_ element:XCUIElement, timeout:UInt = 0) -> Bool
	{
		let clause = "hittable == false"
		let timeout = timeout == 0 ? AutumnTestRunner.instance.config.viewPresentTimeout : timeout
		let success = AutumnUI.waitFor(element, clause: clause, timeout: timeout)
		return success
	}
	
	
	/**
	 * Wait for an element to exist (does not need to be visible or onscreen).
	 *
	 * @param element Element to wait for.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was hittable within time limit, otherwise false.
	 */
	public class func waitForExists(_ element:XCUIElement?, timeout:UInt = 0) -> Bool
	{
		if let e = element
		{
			let clause = "exists == true"
			let timeout = timeout == 0 ? AutumnTestRunner.instance.config.viewPresentTimeout : timeout
			let success = AutumnUI.waitFor(e, clause: clause, timeout: timeout)
			return success
		}
		return false
	}
	
	
	/**
	 * Wait for an element to not exist anymore.
	 *
	 * @param element Element to wait for.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was not found within time limit, otherwise false.
	 */
	public class func waitForNotExists(_ element:XCUIElement, timeout:UInt = 0) -> Bool
	{
		let clause = "exists == false"
		let timeout = timeout == 0 ? AutumnTestRunner.instance.config.viewPresentTimeout : timeout
		let success = AutumnUI.waitFor(element, clause: clause, timeout: timeout)
		return success
	}
	
	
	/**
	 * Wait for a property of an element to become true.
	 *
	 * @param element Element to wait for.
	 * @param property The element's property.
	 * @param timeout Seconds until the wait will time-out as failure.
	 * @return true if element was hittable within time limit, otherwise false.
	 */
	public class func waitForIsTrue(_ object:NSObject, _ property:String, timeout:UInt = 0) -> Bool
	{
		let clause = "\(property) == true"
		let timeout = timeout == 0 ? AutumnTestRunner.instance.config.networkLoginTimeout : timeout
		let success = AutumnUI.waitFor(object, clause: clause, timeout: timeout)
		return success
	}
	
	
	/**
	 * Waits for an element with a specified conditional clause.
	 */
	public class func waitFor(_ element:Any, clause:String, timeout:UInt = 0) -> Bool
	{
		let timeout = timeout == 0 ? AutumnTestRunner.instance.config.viewPresentTimeout : timeout
		let predicate = NSPredicate(format: clause)
		let expectation = AutumnTestRunner.instance.expectation(for: predicate, evaluatedWith: element)
		let result = XCTWaiter.wait(for: [expectation], timeout: TimeInterval(timeout))
		
		switch result
		{
			case .completed:
				return true
			case .invertedFulfillment:
				return true
			case .timedOut:
				return false
			case .incorrectOrder:
				return false
			case .interrupted:
				return false
		}
	}
	
	
	/**
	 * Alternative wait method that uses an interval.
	 *
	 * @param completeBlock Block that is executed after the evalblock evaluates to true or the
	 *                      timeout is reached.
	 * @param timeout Max. time in seconds to wait before giving up.
	 * @param evalblock Block that needs to return true for the wait to result in a success.
	 */
	public class func waitForWithInterval(completeBlock:((_ success:Bool) -> Void)? = nil, timeout:Int = 30, evalblock:@escaping (() -> Bool))
	{
		var count = 0
		let interval = Interval()
		interval.start()
		{
			count += 1
			sleep(1)
			if evalblock() != true && count < timeout { return }
			interval.stop()
			let success = count <= timeout
			completeBlock?(success)
		}
		interval.fire()
	}
	
	
	/**
	 * Ass-simple brute force wait method for when nothing else works.
	 *
	 * @param timeout Max. time in seconds to wait before giving up.
	 * @param evalblock Block that needs to return true for the wait to result in a success.
	 */
	public class func waitUntil(timeout:Int = 30, evalblock:@escaping (() -> Bool))
	{
		var count = 0
		repeat
		{
			if count >= timeout || evalblock() == true
			{
				break
			}
			else
			{
				sleep(1)
			}
			count += 1
		}
		while true
	}
	
	
	/**
	 * Used to decelerate test execution if slow mode is active. Can be used for debugging the
	 * framework during development.
	 */
	public class func decelerate()
	{
		if (AutumnTestRunner.instance.config.slowSeconds > 0) { _ = AutumnUI.wait(AutumnTestRunner.instance.config.slowSeconds) }
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Element Access
	// ----------------------------------------------------------------------------------------------------
	
	public class func getElement(_ id:String, _ type:XCUIElement.ElementType) -> XCUIElement?
	{
		let app = AutumnTestRunner.app
		var query:XCUIElementQuery
		
		switch type
		{
			case .any:
				for t in AutumnUI.elementTypeValues
				{
					if t == XCUIElement.ElementType.any { continue }
					if let e = AutumnUI.getElement(id, t) { return e }
				}
				return nil
			case .other:              query = app.otherElements
			case .group:              query = app.groups
			case .window:             query = app.otherElements
			case .sheet:              query = app.sheets
			case .drawer:             query = app.drawers
			case .alert:              query = app.alerts
			case .dialog:             query = app.dialogs
			case .button:             query = app.buttons
			case .radioButton:        query = app.radioButtons
			case .radioGroup:         query = app.radioGroups
			case .checkBox:           query = app.checkBoxes
			case .disclosureTriangle: query = app.disclosureTriangles
			case .popUpButton:        query = app.popUpButtons
			case .comboBox:           query = app.comboBoxes
			case .menuButton:         query = app.menuButtons
			case .toolbarButton:      query = app.toolbarButtons
			case .popover:            query = app.popovers
			case .keyboard:           query = app.keyboards
			case .key:                query = app.keys
			case .navigationBar:      query = app.navigationBars
			case .tabBar:             query = app.tabBars
			case .tabGroup:           query = app.tabGroups
			case .toolbar:            query = app.toolbars
			case .statusBar:          query = app.statusBars
			case .table:              query = app.tables
			case .tableRow:           query = app.tableRows
			case .tableColumn:        query = app.tableColumns
			case .outline:            query = app.outlines
			case .outlineRow:         query = app.outlineRows
			case .browser:            query = app.browsers
			case .collectionView:     query = app.collectionViews
			case .slider:             query = app.sliders
			case .pageIndicator:      query = app.pageIndicators
			case .progressIndicator:  query = app.progressIndicators
			case .activityIndicator:  query = app.activityIndicators
			case .segmentedControl:   query = app.segmentedControls
			case .picker:             query = app.pickers
			case .pickerWheel:        query = app.pickerWheels
			case .switch:             query = app.switches
			case .toggle:             query = app.toggles
			case .link:               query = app.links
			case .image:              query = app.images
			case .icon:               query = app.icons
			case .searchField:        query = app.searchFields
			case .scrollView:         query = app.scrollViews
			case .scrollBar:          query = app.scrollBars
			case .staticText:         query = app.staticTexts
			case .textField:          query = app.textFields
			case .secureTextField:    query = app.secureTextFields
			case .datePicker:         query = app.datePickers
			case .textView:           query = app.textViews
			case .menu:               query = app.menus
			case .menuItem:           query = app.menuItems
			case .menuBar:            query = app.menuBars
			case .menuBarItem:        query = app.menuBarItems
			case .map:                query = app.maps
			case .webView:            query = app.webViews
			case .incrementArrow:     query = app.incrementArrows
			case .decrementArrow:     query = app.decrementArrows
			case .timeline:           query = app.timelines
			case .ratingIndicator:    query = app.ratingIndicators
			case .valueIndicator:     query = app.valueIndicators
			case .splitGroup:         query = app.splitGroups
			case .splitter:           query = app.splitters
			case .relevanceIndicator: query = app.relevanceIndicators
			case .colorWell:          query = app.colorWells
			case .helpTag:            query = app.helpTags
			case .matte:              query = app.mattes
			case .dockItem:           query = app.dockItems
			case .ruler:              query = app.rulers
			case .rulerMarker:        query = app.rulerMarkers
			case .grid:               query = app.grids
			case .levelIndicator:     query = app.levelIndicators
			case .cell:               query = app.cells
			case .layoutArea:         query = app.layoutAreas
			case .layoutItem:         query = app.layoutItems
			case .handle:             query = app.handles
			case .stepper:            query = app.steppers
			case .tab:                query = app.tabs
			case .touchBar:           query = app.touchBars
			case .statusItem:         query = app.statusItems
			case .application:        query = app.otherElements
		}
		
		let q = query.containing(type, identifier: id)
		if q.count > 0 { return query[id] }
		return nil
	}
	
	
	public class func getElementTypeName(_ type:XCUIElement.ElementType) -> String
	{
		switch type
		{
			case .activityIndicator:  return "activityIndicator"
			case .alert:              return "alert"
			case .any:                return "any"
			case .application:        return "application"
			case .browser:            return "browser"
			case .button:             return "button"
			case .cell:               return "cell"
			case .checkBox:           return "checkBox"
			case .collectionView:     return "collectionView"
			case .colorWell:          return "colorWell"
			case .comboBox:           return "comboBox"
			case .datePicker:         return "datePicker"
			case .decrementArrow:     return "decrementArrow"
			case .dialog:             return "dialog"
			case .disclosureTriangle: return "disclosureTriangle"
			case .dockItem:           return "dockItem"
			case .drawer:             return "drawer"
			case .grid:               return "grid"
			case .group:              return "group"
			case .handle:             return "handle"
			case .helpTag:            return "helpTag"
			case .icon:               return "icon"
			case .image:              return "image"
			case .incrementArrow:     return "incrementArrow"
			case .key:                return "key"
			case .keyboard:           return "keyboard"
			case .layoutArea:         return "layoutArea"
			case .layoutItem:         return "layoutItem"
			case .levelIndicator:     return "levelIndicator"
			case .link:               return "link"
			case .map:                return "map"
			case .matte:              return "matte"
			case .menu:               return "menu"
			case .menuBar:            return "menuBar"
			case .menuBarItem:        return "menuBarItem"
			case .menuButton:         return "menuButton"
			case .menuItem:           return "menuItem"
			case .navigationBar:      return "navigationBar"
			case .other:              return "other"
			case .outline:            return "outline"
			case .outlineRow:         return "outlineRow"
			case .pageIndicator:      return "pageIndicator"
			case .picker:             return "picker"
			case .pickerWheel:        return "pickerWheel"
			case .popover:            return "popover"
			case .popUpButton:        return "popUpButton"
			case .progressIndicator:  return "progressIndicator"
			case .radioButton:        return "radioButton"
			case .radioGroup:         return "radioGroup"
			case .ratingIndicator:    return "ratingIndicator"
			case .relevanceIndicator: return "relevanceIndicator"
			case .ruler:              return "ruler"
			case .rulerMarker:        return "rulerMarker"
			case .scrollBar:          return "scrollBar"
			case .scrollView:         return "scrollView"
			case .searchField:        return "searchField"
			case .secureTextField:    return "secureTextField"
			case .segmentedControl:   return "segmentedControl"
			case .sheet:              return "sheet"
			case .slider:             return "slider"
			case .splitGroup:         return "splitGroup"
			case .splitter:           return "splitter"
			case .staticText:         return "staticText"
			case .statusBar:          return "statusBar"
			case .statusItem:         return "statusItem"
			case .stepper:            return "stepper"
			case .switch:             return "switch"
			case .tab:                return "tab"
			case .tabBar:             return "tabBar"
			case .tabGroup:           return "tabGroup"
			case .table:              return "table"
			case .tableColumn:        return "tableColumn"
			case .tableRow:           return "tableRow"
			case .textField:          return "textField"
			case .textView:           return "textView"
			case .timeline:           return "timeline"
			case .toggle:             return "toggle"
			case .toolbar:            return "toolbar"
			case .toolbarButton:      return "toolbarButton"
			case .touchBar:           return "touchBar"
			case .valueIndicator:     return "valueIndicator"
			case .webView:            return "webView"
			case .window:             return "window"
		}
	}
	

	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - UI Interaction
	// ----------------------------------------------------------------------------------------------------
	
	/**
	 * Sends a tap event to a hittable point computed for the element.
	 *
	 * @param element
	 */
	public class func tap(_ element:XCUIElement?) -> Bool
	{
		if let e = element
		{
			if e.exists && e.isHittable
			{
				e.tap()
			}
			return true
		}
		return false
	}
	
	
	/**
	 * Sends a tap event to a hittable point computed for the element. Does not fail if the eleemnt isn't hittable or doesn't exist.
	 *
	 * @param element
	 */
	public class func tapOptional(_ element:XCUIElement) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.tap()
			return true
		}
		return false
	}
	
	
	/**
	 * Types a string into the element. The element or a descendant must have keyboard focus; otherwise an
	 * error is raised.
	 *
	 * This API discards any modifiers set in the current context by +performWithKeyModifiers:block: so that
	 * it strictly interprets the provided text. To input keys with modifier flags, use  -typeKey:modifierFlags:.
	 *
	 * @param element
	 * @param text
	 */
	public class func typeText(_ element:XCUIElement, text:String) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.typeText(text)
			return true
		}
		return false
	}
	
	
	/**
	 * Sends a swipe-up gesture.
	 * @param element
	 */
	public class func swipeUp(_ element:XCUIElement) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.swipeUp()
			return true
		}
		return false
	}
	
	
	/**
	 * Sends a swipe-down gesture.
	 * @param element
	 */
	public class func swipeDown(_ element:XCUIElement) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.swipeDown()
			return true
		}
		return false
	}
	
	
	/**
	 * Sends a swipe-left gesture.
	 * @param element
	 */
	public class func swipeLeft(_ element:XCUIElement) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.swipeLeft()
			return true
		}
		return false
	}
	
	/**
	 * Sends a swipe-right gesture.
	 * @param element
	 */
	public class func swipeRight(_ element:XCUIElement) -> Bool
	{
		if element.exists && element.isHittable
		{
			element.swipeRight()
			return true
		}
		return false
	}
	
	
	/**
	 * As of yet unsupported!
	 */
	public class func customSwipe(refElement:XCUIElement, startCoord:CGVector, endCoord:CGVector)
	{
		let swipeStartPoint = refElement.coordinate(withNormalizedOffset: startCoord)
		let swipeEndPoint = refElement.coordinate(withNormalizedOffset: endCoord)
		swipeStartPoint.press(forDuration: 0.1, thenDragTo: swipeEndPoint)
	}
	
	
	// ----------------------------------------------------------------------------------------------------
	// MARK: - Assertion
	// ----------------------------------------------------------------------------------------------------
	
	public class func verifyExists(_ element:XCUIElement) -> Bool
	{
		let result = element.exists
		return result
	}
	
	
	public class func verifyHittable(_ element:XCUIElement) -> Bool
	{
		let result = element.isHittable
		return result
	}
}
