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

    var body: some View {
            ScrollView {

                VStack(spacing: 16) {
                    Spacer()

                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Spacer()
                    
                    Button (action:{
                        viewModel.signUp(email: email, password: password)
                        
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
