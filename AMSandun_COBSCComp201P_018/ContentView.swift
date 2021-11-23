//
//  ContentView.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-10-27.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
                VStack{
                    if viewModel.signedIn{
                        TabView() {
                            HomeView()
                                .tabItem{
                                    Image(systemName: "homekit")
                                    Text("Home")
                                        .foregroundColor(Color.black)
                                }
                            BookingView()
                                .tabItem{
                                    Image(systemName: "lifepreserver.fill")
                                    Text("Booking")
                                        .foregroundColor(Color.black)
                                }
                            SettingView()
                                .tabItem{
                                    Image(systemName: "gear")
                                    Text("Setting")
                                        .foregroundColor(Color.black)
                                }
                        }
                    } else {
                        TabView() {
                            HomeView()
                                .tabItem{
                                    Image(systemName: "homekit")
                                    Text("Home")
                                        .foregroundColor(Color.black)
                                }
                            SignInView()
                                .tabItem{
                                    Image(systemName: "lifepreserver.fill")
                                    Text("Booking")
                                        .foregroundColor(Color.black)
                                }
                            SignInView()
                                .tabItem{
                                    Image(systemName: "gear")
                                    Text("Setting")
                                        .foregroundColor(Color.black)
                                }
                        }
                    }
                }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
