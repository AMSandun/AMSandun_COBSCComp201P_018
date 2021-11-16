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
            VStack {
                List(homeViewModel.slots){ slot in
                        VStack{
                            if (slot.slotStatus == "1"){
                                HStack{
                                    Text("Slot : \(slot.slotid)")
                                    Spacer()
                                    Text("Slot Type : \(slot.slotType)")
                                    Spacer()
                                    Text(slot.vehicleNo)
                                }
                                .padding()
                                .foregroundColor(Color.black)
                                .background(Color.orange)
                            }
                            else {
                                HStack{
                                    Text("Slot : \(slot.slotid)")
                                    Spacer()
                                    Text("Slot Type : \(slot.slotType)")
                                    Spacer()
                                    Text(slot.vehicleNo)
                                }
                                .padding()
                                .foregroundColor(Color.black)
                                .background(Color.green)
                            }
                        }
                    }
            }
            .onAppear(){
                self.homeViewModel.getSlotDetails()
            }
        .navigationTitle("HOME")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
