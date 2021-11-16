//
//  BookingViewModel.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-16.
//

import Foundation
import FirebaseFirestore

class BookingViewModel: ObservableObject {
    var database = Firestore.firestore()
    @Published var availableslots = [SlotPickerModel]()
    
    func getAvailableSlots(){

        database.collection("slots").order(by: "slotId").whereField("slotStatus", isEqualTo: "2").addSnapshotListener{ (querySnapshot, error) in
            guard let doc = querySnapshot?.documents else {
                print("Document does not exist")
                return
            }
            self.availableslots = doc.map { ( QueryDocumentSnapshot) -> SlotPickerModel in
                let data = QueryDocumentSnapshot.data()
                let id = QueryDocumentSnapshot.documentID
                let slotid = data["slotId"] as? Int ?? 0
                let slotype = data["slotType"] as? String ?? ""
                print("available ones",data)
                return SlotPickerModel(id: id, slotid: slotid, slotype: slotype)
                
            }
        }
        
    }
}
