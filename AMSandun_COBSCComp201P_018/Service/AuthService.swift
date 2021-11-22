//
//  AuthService.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-22.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol{
    func SignIn(email: String, password: String, completion: @escaping (Result<Void, Error>)->  Void )
}

final class AuthService : AuthServiceProtocol{
    let auth = Auth.auth();
    func SignIn(email: String, password: String, completion: @escaping (Result<Void, Error>)->  Void ){
        auth.signIn(withEmail: email, password: password){ (authResult, error) in
            if let err = error as NSError? {
                switch AuthErrorCode(rawValue: err.code) {
                case .userDisabled:
                    print("Error: The user account has been disabled by an admin.")
                    completion(.failure(err))
                case .wrongPassword:
                    print("Error: The password is invalid.")
                    completion(.failure(err))
                case .invalidEmail:
                    print("Error: The Email is invalid.")
                    completion(.failure(err))
                default:
                    print(err.localizedDescription)
                    completion(.failure(err))
                }
            }
            else{
                completion(.success(()))
            }
        }
    }
}


