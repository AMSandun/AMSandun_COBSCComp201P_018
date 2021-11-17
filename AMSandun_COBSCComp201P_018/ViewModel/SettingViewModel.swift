//
//  SettingViewModel.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-05.
//

import Foundation
import FirebaseFirestore
import SwiftUI
import FirebaseAuth

class SettingViewModel : ObservableObject{
    var database = Firestore.firestore()
    let auth = Auth.auth()
    @Published var user = [UserDetails]()
    
    func getUserDetails(){
        let uid = auth.currentUser?.uid
        database.collection("users").whereField("RegistrationNo", isEqualTo: uid ?? "").addSnapshotListener{ (querySnapshot, error) in
            guard let doc = querySnapshot?.documents else {
                print("Users does not exist")
                return
            }
            self.user = doc.map { ( QueryDocumentSnapshot) -> UserDetails in
                let data = QueryDocumentSnapshot.data()
                let id = QueryDocumentSnapshot.documentID
                let fullname = data["Name"] as? String ?? ""
                let nic = data["NIC"] as? String ?? ""
                let vno = data["VehicleNo"] as? String ?? ""
                print(data)
                return UserDetails(id: id, fullname: fullname, nic: nic, regno: id, vehicleno: vno)
                
            }
        }
        
    }
}
