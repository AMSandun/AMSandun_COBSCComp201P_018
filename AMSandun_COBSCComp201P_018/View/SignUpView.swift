//
//  SignUpView.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-10-31.
//

import SwiftUI

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    @StateObject var userModel = UserModel()

    var body: some View {
            ScrollView {
                VStack(spacing: 16) {
                    Spacer()
                    Group {
                        TextField("Full Name", text: $userModel.fullname)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        TextField("NIC No", text: $userModel.nic)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        TextField("Vehicle No", text: $userModel.vehicleno)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        TextField("Email", text: $userModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        SecureField("Password", text: $userModel.password)
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Spacer()
                    Button (action:{
                        
                        viewModel.signUp(userModel: userModel)
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("SIGN UP")
                                .foregroundColor(.black)
                                .padding(.vertical, 10)
                                .font(.system(size: 18, weight: .semibold))
                            Spacer()
                        }.background(Color.green)

                    })
                }
                .padding()

            }
            .navigationTitle("SIGN UP")
            .background(Color(.init(white: 0, alpha: 0.20))
                            .ignoresSafeArea())
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
