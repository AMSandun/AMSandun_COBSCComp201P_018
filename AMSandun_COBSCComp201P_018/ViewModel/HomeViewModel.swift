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
    @Published var slots = [SlotDetails]()
    
    func getSlotDetails(){
        database.collection("slots").order(by: "slotId").addSnapshotListener{ (querySnapshot, error) in
            guard let doc = querySnapshot?.documents else {
                print("Document does not exist")
                return
            }
            self.slots = doc.map { ( QueryDocumentSnapshot) -> SlotDetails in
                let data = QueryDocumentSnapshot.data()
                let id = QueryDocumentSnapshot.documentID
                let slotid = data["slotId"] as? Int ?? 0
                let slotStatus = data["slotStatus"] as? String ?? ""
                let slotType = data["slotType"] as? String ?? ""
                let vehicleNo = data["vehicleNo"] as? String ?? ""
                let cancelTime = data["bookingTime"] as? String ?? ""
                print(data)
                return SlotDetails(id: id, slotid: slotid, slotStatus: slotStatus, slotType: slotType, vehicleNo: vehicleNo , cancelTime: cancelTime)
                
            }
        }
        
    }
}
