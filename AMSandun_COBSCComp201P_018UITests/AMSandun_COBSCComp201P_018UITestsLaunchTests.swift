//
//  AMSandun_COBSCComp201P_018UITestsLaunchTests.swift
//  AMSandun_COBSCComp201P_018UITests
//
//  Created by sandun lakmal on 2021-10-27.
//

import XCTest

class AMSandun_COBSCComp201P_018UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
