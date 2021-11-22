//
//  MockAuthenticationService.swift
//  AMSandun_COBSCComp201P_018Tests
//
//  Created by sandun lakmal on 2021-11-22.
//

import Foundation
@testable import AMSandun_COBSCComp201P_018

final class MockAuthenticationService : AuthServiceProtocol{
    
    func SignIn(email: String, password: String, completion: @escaping (Result<Void, Error>)->  Void ){
        completion(.success(()))
    }
}
