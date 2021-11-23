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
    @Published var signInErrorMessage = ""
    @Published var signUpErrorMessage = ""
    @Published var forgotPassword = ""
    private let authenticationService : AuthServiceProtocol
        
    init(authService: AuthServiceProtocol = AuthService()){
        self.authenticationService = authService
    }
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    
    func signIn(credentialModel: CredentialModel) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.signInErrorMessage = ""
                }
        if(credentialModel.email == ""){
            self.signInErrorMessage = "Email is required!"
        } else if(credentialModel.password == ""){
            self.signInErrorMessage = "Password is required!"
        }
        else{
            authenticationService.SignIn(email: credentialModel.email, password: credentialModel.password ){ result in
                        switch result{
                        case .success:
                            DispatchQueue.main.async {
                                self.signedIn = true
                            }
                        case let .failure(error):
                            self.signInErrorMessage = error.localizedDescription
                        }
                    }
        }
    }
    
    func signUp(userModel: UserModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.signUpErrorMessage = ""
                }
        if(userModel.fullname == ""){
            self.signUpErrorMessage = "Name is required!"
        } else if(userModel.nic == ""){
            self.signUpErrorMessage = "NIC is required!"
        } else if(userModel.vehicleno == "") {
            self.signUpErrorMessage = "Vehicle Number is required!"
        } else if(userModel.email == ""){
            self.signUpErrorMessage = "Email is required!"
        } else if(userModel.password == ""){
            self.signUpErrorMessage = "Password is required!"
        } else if(userModel.password.count < 6){
            self.signUpErrorMessage = "Required strong password!"
        }
        else{
            
            auth.createUser(withEmail: userModel.email, password: userModel.password) { [weak self]result,
                error in
                guard result != nil, error == nil else {
                    self?.signUpErrorMessage = error?.localizedDescription ?? ""
                    return
                }
                
                DispatchQueue.main.async {
                    let user = Auth.auth().currentUser
                    var uid : String = ""
                    if let user = user{
                        uid = user.uid
                        let authUser : [String : Any] = [
                            "Name": userModel.fullname,
                            "NIC": userModel.nic,
                            "RegistrationNo": uid,
                            "VehicleNo": userModel.vehicleno,
                            "Email": userModel.email
                        ]
                        self?.databse.collection("users").document(uid).setData(authUser)
                    }
                    
                    self?.signedIn = true
                }
            }
            
        }
        
    }
    
    func signedOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
    
    func forgotPassword(email: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.forgotPassword = ""
                }
        if (email == "") {
            self.forgotPassword = "Email is required!"
        }
        else{
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                        DispatchQueue.main.async {

                            if let error = error {
                                print(error.localizedDescription)
                                self.forgotPassword = error.localizedDescription
                            }
                            else {
                                self.forgotPassword = "We send you an email with instructions on how to reset your password."
                            }
                        }
                    }
            
        }
        
    }
}
