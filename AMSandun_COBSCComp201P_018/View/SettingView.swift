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
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            if let user = settingsViewModel.user.first {
                Form {
                    Section (header: Text("User Detail") .fontWeight(.bold) .foregroundColor(Color.black) .font(.system(size: 17))){
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
                    }
                    Button(action: {
                        showingAlert = true
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Sign Out")
                                .foregroundColor(.black)
                                .padding(.vertical, 10)
                                .font(.system(size: 18, weight: .semibold))
                            Spacer()
                        }.background(Color.red)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Do you want to sign out?"), message: Text("NIBM Parking"), primaryButton: .destructive(Text("YES")){
                                    viewModel.signedOut()
                                },
                                      secondaryButton: .cancel(){
                                })
                            }
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
