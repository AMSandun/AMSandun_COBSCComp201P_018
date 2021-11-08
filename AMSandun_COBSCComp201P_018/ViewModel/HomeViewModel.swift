//
//  HomeViewModel.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-08.
//

import Foundation
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    var database = Firestore.firestore()
    @Published var users = [UserDetails]()
    
    func getSlotDetails(){
        database.collection("users").addSnapshotListener{ (querySnapshot, error) in
            guard let doc = querySnapshot?.documents else {
                print("Document does not exist")
                return
            }
            self.users = doc.map { ( QueryDocumentSnapshot) -> UserDetails in
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
