//
//  AMSandun_COBSCComp201P_018App.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-10-27.
//

import SwiftUI
import Firebase

@main
struct AMSandun_COBSCComp201P_018App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application ( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                       [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
