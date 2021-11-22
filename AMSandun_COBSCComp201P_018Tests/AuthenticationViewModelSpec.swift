//
//  AuthenticationViewModelSpec.swift
//  AMSandun_COBSCComp201P_018Tests
//
//  Created by sandun lakmal on 2021-11-22.
//

import XCTest
@testable import AMSandun_COBSCComp201P_018

class AuthenticationViewModelSpec: XCTestCase {

    var viewModel : AppViewModel!
        var mockAuthService : MockAuthenticationService!
        
        override func setUp() {
            mockAuthService = MockAuthenticationService()
            viewModel = .init(authSerive: mockAuthService)
        }
        
        func testSignInWithCorrectDetails(){
            let credentialUser = CredentialModel()
            viewModel.signIn(credentialModel: credentialUser)
            XCTAssertTrue(viewModel.isSignedIn)
        }

}
