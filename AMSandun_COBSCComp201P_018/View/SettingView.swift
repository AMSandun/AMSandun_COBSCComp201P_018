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
