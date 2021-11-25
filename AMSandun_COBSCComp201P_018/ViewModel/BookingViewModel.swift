//
//  BookingViewModel.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-16.
//

import Foundation
import FirebaseFirestore
import CoreLocation

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
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.reservationErrorMessage = ""
                }
        if(bookingModel.selectedSlot ==  "" ){
            self.reservationErrorMessage = "Please select a parking slot"
        }
        else if(getDistance() > 1.00 ){
            self.reservationErrorMessage = "You are not in range to book slot"
        }
        else{
            let ReserveBooking : [String : Any] = [
                "VehicleNo": Vno,
                "RegistrationNo": Regno,
                "SelectedSlot": bookingModel.selectedSlot,
                "BookingDate": FieldValue.serverTimestamp(),
                "BookingTime": bookingTime()
            ]
            self.database.collection("reservations").addDocument(data: ReserveBooking){ err in
                if let error = err{
                    print("Error", error.localizedDescription)
                    self.reservationErrorMessage = error.localizedDescription
                } else {
                    self.database.collection("slots").document(bookingModel.selectedSlot).updateData(["slotStatus" : "1" , "vehicleNo": Vno , "bookingTime": self.bookingCanceledTime()]){ err in
                        if let err = err {
                            print("Error", err)
                            self.reservationErrorMessage = err.localizedDescription
                        }
                        else{
                            self.reservationErrorMessage = "Reservation successful!"
                        }
                    }
                }
            }
        }
    }
    
    func bookingTime() -> String {
            let timeFormater = DateFormatter()
            timeFormater.dateFormat = "HH:mm"
            let bookingTime = timeFormater.string(from: Date() as Date)
            return bookingTime
        }

    func bookingCanceledTime() -> String {
            let timeFormater = DateFormatter()
            timeFormater.dateFormat = "HH:mm"
            let canceldTime = timeFormater.string(from: Date().addingTimeInterval(10*60) as Date)
            return canceldTime
        }
    func getDistance() -> Double{
            let NIBMLocation = CLLocation(latitude: 6.9064, longitude: 79.8706)
            //Cricket Borad location
            let locationInRange = CLLocation(latitude: 6.9060, longitude: 79.8682)
            //my home location (not in range)
            //let locationOutOfRange = CLLocation(latitude: 7.0122, longitude: 79.9761)
            
            //distance in kilometers
            let distanceToNIBM = NIBMLocation.distance(from: locationInRange)/1000
            print(distanceToNIBM)
            return distanceToNIBM
        }
    
}
