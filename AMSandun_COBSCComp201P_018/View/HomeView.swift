//
//  HomeView.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-02.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                List(homeViewModel.slots){ slot in
                        VStack{
                            if (slot.slotStatus == "1"){
                                HStack{
                                    Text("Slot : \(slot.slotid)")
                                    Spacer()
                                    Text("Slot Type : \(slot.slotType)")
                                    Spacer()
                                    VStack{
                                        Text(slot.vehicleNo)
                                        Text("Time : \(slot.cancelTime)")
                                    }
                                    
                                }
                                .padding()
                                .foregroundColor(Color.black)
                                .background(Color.orange)
                                .clipShape(Capsule())
                            }
                            else {
                                HStack{
                                    Text("Slot : \(slot.slotid)")
                                    Spacer()
                                    Text("Slot Type : \(slot.slotType)")
                                    Spacer()
                                    Text("Available")
                                        .fontWeight(.bold)
                                }
                                .padding()
                                .foregroundColor(Color.black)
                                .background(Color.green)
                                .clipShape(Capsule())
                            }
                        }
                    }
                .listStyle(SidebarListStyle())
            }
            .onAppear(){
                self.homeViewModel.getSlotDetails()
            }
            .navigationTitle("HOME")
            .background(Color(.init(white: 0, alpha: 0.20))
                            .ignoresSafeArea())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
