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
    @Published var reservationErrorMessage = ""
    
    func getAvailableSlots(){
        database.collection("slots").order(by: "slotId").whereField("slotStatus", isEqualTo: "2").addSnapshotListener{ (querySnapshot, error) in
            guard let doc = querySnapshot?.documents else {
                print("Slots does not exist")
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
    
    func createReserve(bookingModel: BookingModel, Vno: String, Regno: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 13) {
                    self.reservationErrorMessage = ""
                }
        if(bookingModel.selectedSlot ==  "" ){
            self.reservationErrorMessage = "Please select a parking slot"
        }
        else{
            let ReserveBooking : [String : Any] = [
                "VehicleNo": Vno,
                "RegistrationNo": Regno,
                "SelectedSlot": bookingModel.selectedSlot,
                "BookingDate": FieldValue.serverTimestamp()
            ]
            self.database.collection("reservations").addDocument(data: ReserveBooking){ err in
                if let error = err{
                    print("Error", error.localizedDescription)
                    self.reservationErrorMessage = error.localizedDescription
                } else {
                    self.database.collection("slots").document(bookingModel.selectedSlot).updateData(["slotStatus" : "1" , "vehicleNo": Vno]){ err in
                        if let err = err {
                            print("Error", err)
                            self.reservationErrorMessage = err.localizedDescription
                        }
                    }
                }
            }
        }
    }
    
}
