//
//  SettingView.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-02.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @StateObject var settingsViewModel = SettingViewModel()
    
    var body: some View {
        VStack {
            if let user = settingsViewModel.user.first {
                Form {
                    HStack{
                        Text("Full Name :")
                        Text(user.fullname)
                    }
                    padding()
                    HStack{
                        Text("NIC No :")
                        Text(user.nic)
                    }
                    padding()
                    HStack{
                        Text("Registration No :")
                        Text(user.regno)
                    }
                    padding()
                    HStack{
                        Text("Vehicle No :")
                        Text(user.vehicleno)
                    }
                    padding()
                    Button(action: {
                        viewModel.signedOut()
                    }, label: {
                        Text("Signed Out")
                            .foregroundColor(Color.red)
                            .padding()
                    })
                }
            }
        }
        .onAppear(){
            settingsViewModel.getUserDetails()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
