//
//  AuthViewModel.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-02.
//

import Foundation
import FirebaseAuth
import SwiftUI
import FirebaseDatabase

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    let db = Database.database().reference()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self]result,
            error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self]result,
            error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
//                let user = Auth.auth().currentUser
//                self?.db.child("users").child(user.uid).setValue(["email": email])
                
                self?.signedIn = true
            }
        }
    }
    
    func signedOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
}
