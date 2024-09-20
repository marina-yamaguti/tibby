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

    var body: some View {
        VStack(spacing: 0) {
            PageHeader(title: "Settings", symbol: "TibbySymbolSettings")
            ScrollView {
                VStack {
                    VStack(spacing: 16) {
                        CodeRedeemView(viewModel: vm)
                        ForEach(vm.settingsSections, id: \.self) { section in
                            SettingsComponent(trailingType: section.trailingType, title: section.title, labels: section.labels, color: section.color)
                        }
                       
                        
                        ResourcesComponent()
                    }
                    .padding(16)
                    Spacer()
                }
                .navigationBarBackButtonHidden()
            }
        }
        .background(.tibbyBaseWhite)
        .ignoresSafeArea(.container, edges: .top)
    }
}
