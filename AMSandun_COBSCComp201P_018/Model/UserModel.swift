//
//  UserModel.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-03.
//

import Foundation

class UserModel : ObservableObject{
    
    @Published var fullname = ""
    @Published var nic = ""
    @Published var regno = ""
    @Published var vehicleno = ""
    @Published var email = ""
    @Published var password = ""
}
