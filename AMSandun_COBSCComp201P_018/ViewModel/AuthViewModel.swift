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
import FirebaseFirestore

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    let db = Database.database().reference()
    let databse = Firestore.firestore()
    
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
    func signUp(userModel: UserModel) {
        auth.createUser(withEmail: userModel.email, password: userModel.password) { [weak self]result,
            error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let authUser : [String : Any] = [
                    "Name": userModel.fullname,
                    "NIC": userModel.nic,
                    "RegistrationNo": userModel.regno,
                    "VehicleNo": userModel.vehicleno,
                    "Email": userModel.email
                ]
                let user = Auth.auth().currentUser
                var uid : String = ""
                if let user = user{
                    uid = user.uid
                    self?.databse.collection("users").document(uid).setData(authUser)
                }
                
                self?.signedIn = true
            }
        }
    }
    
    func signedOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
}
