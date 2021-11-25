//
//  AMSandun_COBSCComp201P_018UITests.swift
//  AMSandun_COBSCComp201P_018UITests
//
//  Created by sandun lakmal on 2021-10-27.
//

import XCTest

class AMSandun_COBSCComp201P_018UITests: XCTestCase {

    func signInTest() throws {
        // UI tests must launch the application that they test.
        continueAfterFailure = false
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
