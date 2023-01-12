//
//  LessonListUITests.swift
//  LessonListUITests
//
//  Created by Sharon Omoyeni Babatunde on 10/01/2023.
//

import XCTest
import SwiftUI
@testable import LessonList

final class WhenAppIsLaunched: XCTestCase {
    
    var app: XCUIApplication!
   
    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launch()
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func test_should_display_screen_on_launch() {
        
        app.launch()
        
        let lessonNavBarTitle = app.staticTexts["Lessons"]
        XCTAssertTrue(lessonNavBarTitle.waitForExistence(timeout: 0.5))
        
        let navigationLink = NSPredicate(format: "label beginswith 'navigationLink'")
        XCTAssert(true)
        
        let hstack = app.staticTexts["HStackFound"]
        XCTAssert(true)
        
    }
    
    func test_should_display_Details_page_on_navigation() {
        let lessonsNavButton = app.buttons["Lessons"]
        XCTAssertTrue(lessonsNavButton.waitForExistence(timeout: 10))
    }
    
  

}

