//
//  BookingModel.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-16.
//

import Foundation

struct SlotPickerModel : Identifiable{
 
    var id: String
    var slotid: Int
    var slotype: String
}

class BookingModel : ObservableObject{
    
    @Published var selectedSlot = ""
}
