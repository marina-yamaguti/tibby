//
//  SettingsView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @ObservedObject var constants = Constants()
    //@ObservedObject var moneyViewModel = MoneyViewModel()
    @ObservedObject var vm = SettingsViewModel()
    @EnvironmentObject var service: Service
    @State var showHealthAlert = false


    var body: some View {
        VStack(spacing: 0) {
            PageHeader(title: "Settings", symbol: TibbySymbols.gearBlack.rawValue)
            ScrollView {
                VStack {
                    VStack(spacing: 16) {
                        CodeRedeemView(viewModel: vm)
                        ForEach(vm.settingsSections, id: \.self) { section in
                            SettingsComponent(showHealthAlert: $showHealthAlert, trailingType: section.trailingType, title: section.title, labels: section.labels, color: section.color)
                        }
                       
                        
                        ResourcesComponent()
                    }
                    .padding(16)
                    Spacer()
                }
                .navigationBarBackButtonHidden()
            }
        }
        .popup(isPresented: $showHealthAlert) {
            CustomPopUpView(isPresented: $showHealthAlert, title: "How to Allow", description: "Go to Settings > Health > Tibby > Allow Data Access.", actionType: .settings)
        }
        .popup(isPresented: $vm.showRedeemSuccess) {
            CustomPopUpView(isPresented: $vm.showRedeemSuccess, title: "Code Redeemed", description: "You were awarded with 100 coins, 20 gems and 1 special hat!", actionType: .ok)
        }
        .popup(isPresented: $vm.codeAlreadyRedeemedAlert) {
            CustomPopUpView(isPresented: $vm.codeAlreadyRedeemedAlert, title: "Error Reedeming", description: "You have already redeemed this code.", actionType: .ok)
        }
        .popup(isPresented: $vm.invalidAlert) {
            CustomPopUpView(isPresented: $vm.invalidAlert, title: "Error Reedeming", description: "Oops! The code you entered is not valid. Please try again.", actionType: .ok)
        }
        .background(.tibbyBaseWhite)
        .ignoresSafeArea(.container, edges: .top)
    }
}
