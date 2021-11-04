//
//  SignInView.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-10-31.
//

import SwiftUI
import Firebase

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
            ScrollView {

                VStack(spacing: 16) {
                    Spacer()
                    Button {
                    } label: {
                        Image("NIBMImage")
                            .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200)
                    }
                    
                    Spacer()
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button {
                        viewModel.forgotPassword(email: email)
                    } label: {
                        Text("Forgot Password?")                            
                    }
                    Spacer()
                    
                    Button(action: {
                        viewModel.signIn(email: email, password: password)
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("SIGN IN")
                                .foregroundColor(.black)
                                .padding(.vertical, 10)
                                .font(.system(size: 18, weight: .semibold))
                            Spacer()
                        }.background(Color.green)

                    })
                }
                .padding()
                Spacer()
                Text("---------------------- OR ----------------------")
                    .foregroundColor(Color.black)
                Spacer()
                NavigationLink("Create Account", destination: SignUpView())
                    .foregroundColor(Color.blue)

            }
            .navigationTitle("SIGN IN")
            .background(Color(.init(white: 0, alpha: 0.20))
                            .ignoresSafeArea())
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
