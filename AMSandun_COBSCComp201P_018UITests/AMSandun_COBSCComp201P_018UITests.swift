//
//  AMSandun_COBSCComp201P_018UITests.swift
//  AMSandun_COBSCComp201P_018UITests
//
//  Created by sandun lakmal on 2021-10-27.
//

import XCTest

class AMSandun_COBSCComp201P_018UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func signInTest() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        let bookingButton = app.tabBars["Tab Bar"].buttons["Booking"]
        bookingButton.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["Email"].tap()
        elementsQuery.secureTextFields["Password"].tap()
        elementsQuery.buttons["SIGN IN"].tap()
        bookingButton.tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
