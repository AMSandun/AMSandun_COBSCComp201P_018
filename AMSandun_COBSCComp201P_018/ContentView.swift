//
//  ContentView.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-10-27.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self]result,
            error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self]result,
            error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signedOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
}

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        NavigationView {
            if viewModel.signedIn{
                VStack{
                    Text("you are signed in")
                    Button(action: {
                        viewModel.signedOut()
                    }, label: {
                        Text("Signed Out")
                            .background(Color.green)
                            .foregroundColor(Color.blue)
                            .padding()
                    })
                }
                
            } else{
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

//struct SignIn1View: View {
//    @State var email = ""
//    @State var password = ""
//    @EnvironmentObject var viewModel: AppViewModel
//
//    var body: some View {
//            ScrollView {
//
//                VStack(spacing: 16) {
//                    Spacer()
//
//                    Group {
//                        TextField("Email", text: $email)
//                            .keyboardType(.emailAddress)
//                            .autocapitalization(.none)
//                        SecureField("Password", text: $password)
//                    }
//                    .padding(12)
//                    .background(Color.white)
//
//                    Spacer()
//
//                    Button(action: {
//                        viewModel.signIn(email: email, password: password)
//
//                    }, label: {
//                        HStack {
//                            Spacer()
//                            Text("SIGN IN")
//                                .foregroundColor(.black)
//                                .padding(.vertical, 10)
//                                .font(.system(size: 18, weight: .semibold))
//                            Spacer()
//                        }.background(Color.green)
//
//                    })
//                }
//                .padding()
//
//                NavigationLink("Create Account", destination: SignUp1View())
//
//            }
//            .navigationTitle("SIGN IN")
//            .background(Color(.init(white: 0, alpha: 0.20))
//                            .ignoresSafeArea())
//    }
//}
//
//struct SignUp1View: View {
//    @State var email = ""
//    @State var password = ""
//    @EnvironmentObject var viewModel: AppViewModel
//
//    var body: some View {
//            ScrollView {
//
//                VStack(spacing: 16) {
//                    Spacer()
//
//                    Group {
//                        TextField("Email", text: $email)
//                            .keyboardType(.emailAddress)
//                            .autocapitalization(.none)
//                        SecureField("Password", text: $password)
//                    }
//                    .padding(12)
//                    .background(Color.white)
//
//                    Spacer()
//
//                    Button (action:{
//                        viewModel.signUp(email: email, password: password)
//
//                    }, label: {
//                        HStack {
//                            Spacer()
//                            Text("SIGN UP")
//                                .foregroundColor(.black)
//                                .padding(.vertical, 10)
//                                .font(.system(size: 18, weight: .semibold))
//                            Spacer()
//                        }.background(Color.green)
//
//                    })
//                }
//                .padding()
//
//            }
//            .navigationTitle("SIGN UP")
//            .background(Color(.init(white: 0, alpha: 0.20))
//                            .ignoresSafeArea())
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
