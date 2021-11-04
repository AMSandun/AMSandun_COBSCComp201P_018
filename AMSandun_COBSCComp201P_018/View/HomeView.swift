//
//  HomeView.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-02.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView{
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 4), spacing:15){
                    ForEach(0..<20, id: \.self){index in
                        
                        Color.gray
                            .frame(width: getWidth(), height: getWidth())
                            .cornerRadius(15)

                    }
                }
                .padding(15)
            }
        }
    }
    
    func getWidth()->CGFloat{
        let width = UIScreen.main.bounds.width - (30 + 30)
        
        return width / 4
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
