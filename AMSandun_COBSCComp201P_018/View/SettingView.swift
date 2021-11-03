//
//  SettingView.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-02.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        VStack {
            Text("Setting page")
            Group {
                HStack {
                    Text("Full Name ")
                    TextField("", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .disabled(true)
                }
                HStack {
                    Text("NIC No ")
                    TextField("", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .disabled(true)
                }
                HStack {
                    Text("Registration No ")
                    TextField("", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .disabled(true)
                }
                HStack {
                    Text("Vehicle No ")
                    TextField("", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .disabled(true)
                }
            }
            .padding(12)
            .background(Color.white)
            Button(action: {
                viewModel.signedOut()
            }, label: {
                Text("Signed Out")
                    .background(Color.green)
                    .foregroundColor(Color.black)
                    .padding()
            })
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
