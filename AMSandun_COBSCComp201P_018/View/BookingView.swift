//
//  BookingView.swift
//  AMSandun_COBSCComp201P_018
//
//  Created by sandun lakmal on 2021-11-02.
//

import SwiftUI
import CodeScanner

struct BookingView: View {
    
    @StateObject var settingsViewModel = SettingViewModel()
    @StateObject var bookingViewModel = BookingViewModel()
    @StateObject var bookingModel = BookingModel()
    @State private var showingAlert = false
    @State var isPerentingScanner = false
        
    var scannerSheet: some View{
        CodeScannerView(codeTypes: [.qr], completion: {
            result in
            if case let .success(slotId) = result{
                self.isPerentingScanner = false
                self.bookingModel.selectedSlot = slotId
                bookingViewModel.createReserve(bookingModel: bookingModel, Vno: settingsViewModel.user.first?.vehicleno ?? "" , Regno: settingsViewModel.user.first?.regno ?? "")
            }
        })
    }
    
    var body: some View {
        NavigationView{
            VStack{
                if let user = settingsViewModel.user.first {
                    Form {
                        Section (header: Text("User Detail") .fontWeight(.bold) .foregroundColor(Color.black) .font(.system(size: 17))){
                                HStack{
                                    Text("Registration No :")
                                        .foregroundColor(Color.blue)
                                        .fontWeight(.bold)
                                    Text(user.regno)
                                        .foregroundColor(Color.black)
                                    
                                }
                                HStack{
                                    Text("Vehicle No :")
                                        .foregroundColor(Color.blue)
                                        .fontWeight(.bold)
                                    Text(user.vehicleno)
                                        .foregroundColor(Color.black)
                                }
                            padding()
                        }
                        Section (header: Text("Available Slots") .fontWeight(.bold) .foregroundColor(Color.black) .font(.system(size: 17))){
                            VStack{
                                Picker("Please select a slot",selection: $bookingModel.selectedSlot) {
                                    ForEach(bookingViewModel.availableslots) { slot in
                                        HStack{
                                            Text(String(slot.slotid))
                                                .foregroundColor(Color.black)
                                                .fontWeight(.bold)
                                            Text(slot.slotype)
                                                .foregroundColor(Color.black)
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                            }
                        }
                        HStack{
                            Spacer()
                            Text(bookingViewModel.reservationErrorMessage)
                                .foregroundColor(Color.red)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
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
                                        bookingViewModel.createReserve(bookingModel: bookingModel, Vno: settingsViewModel.user.first?.vehicleno ?? "" , Regno: settingsViewModel.user.first?.regno ?? "")
                                    },
                                          secondaryButton: .cancel(){
                                    })
                                }
                                .cornerRadius(15)

                        })
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {self.isPerentingScanner = true}, label: {
                                Text("Scan the QR code")
                                    .foregroundColor(Color.blue)
                            })
                                .sheet(isPresented: $isPerentingScanner){
                                    self.scannerSheet
                            }
                            Spacer()
                        }
                    }
                }
            }
            .onAppear(){
                settingsViewModel.getUserDetails()
                bookingViewModel.getAvailableSlots()
            }
            .navigationTitle("BOOKING")
            
        }
        
        
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
