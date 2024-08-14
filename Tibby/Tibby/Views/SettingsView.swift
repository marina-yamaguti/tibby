//
//  SettingsView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            PageHeader(title: "Tibby Book", symbol: TibbySymbols.play.rawValue)
            VStack(spacing: 16) {
                SettingsComponent(isOn: true, trailingType: .toggleButton, title: "Notifications", label: "Enable notifications", color: .tibbyBaseRed)
            }
            .padding(16)
            Spacer()
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(.tibbyBaseWhite)
    }
}

#Preview {
    SettingsView()
}
