//
//  BookingView.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-02.
//

import SwiftUI

struct BookingView: View {
    
    @StateObject var settingsViewModel = SettingViewModel()
    @StateObject var bookingViewModel = BookingViewModel()
    @StateObject var bookingModel = BookingModel()
    @State private var showingAlert = false
    
    var body: some View {
        VStack{
            if let user = settingsViewModel.user.first {
                Form {
                    Section (header: Text("User Detail") .fontWeight(.bold) .foregroundColor(Color.black) .font(.system(size: 17))){
                            HStack{
                                Text("Registration No :")
                                Text(user.regno)
                            }
                            HStack{
                                Text("Vehicle No :")
                                Text(user.vehicleno)
                            }
                        padding()
                    }
                    Section (header: Text("Available Slots") .fontWeight(.bold) .foregroundColor(Color.black) .font(.system(size: 17))){
                        VStack{
                            Picker("Please select a slot",selection: $bookingModel.selectedSlot) {
                                ForEach(bookingViewModel.availableslots) { slot in
                                    HStack{
                                        Text(String(slot.slotid))
                                        Text(slot.slotype)
                                    }
                                    
                                }
                            }
                        }
                    }
                    Spacer()
                    Button (action:{
                        showingAlert = true
                    }, label: {
                        HStack {
                            Spacer()
                            Text("RESERVE")
                                .foregroundColor(.black)
                                .padding(.vertical, 10)
                                .font(.system(size: 18, weight: .semibold))
                            Spacer()
                        }.background(Color.green)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Do you want to reserve a slot?"), message: Text("NIBM Parking"), primaryButton: .destructive(Text("YES")){
                                    bookingViewModel.createReserve(bookingModel: bookingModel)
                                },
                                      secondaryButton: .cancel(){
                                })
                            }

                    })
                }
            }
        }
        .onAppear(){
            settingsViewModel.getUserDetails()
            bookingViewModel.getAvailableSlots()
        }
        
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
