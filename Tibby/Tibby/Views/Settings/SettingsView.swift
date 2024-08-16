//
//  SettingsView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var constants = Constants()
    @ObservedObject var vm = SettingsViewModel()
    var body: some View {
        VStack {
            PageHeader(title: "Settings", symbol: "TibbySymbolSettings")
            VStack(spacing: 16) {
                //TODO add notifications when ready
                SettingsComponent(trailingType: .toggleButton, title: "Haptics", label: "Phone Vibration", color: .tibbyBaseGreen)
    
                SettingsComponent(trailingType: .toggleButton, title: "Sounds", label: "Music", color: .tibbyBaseBlue)

                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Credits")
                            .font(.typography(.title))
                        VStack(alignment: .leading) {
                            Text("Design")
                                .font(.typography(.label2))
                            Text("Mateus Moura Godinho")
                                .font(.typography(.body2))
                            Text("Marina Geller Yamaguti")
                                .font(.typography(.body2))
                        }
                        VStack(alignment: .leading) {
                            Text("Development")
                                .font(.typography(.label2))
                            Text("Felipe Elsner da Silva")
                                .font(.typography(.body2))
                            Text("Maria Eduarda Maciel")
                                .font(.typography(.body2))
                            Text("Marina Geller Yamaguti")
                                .font(.typography(.body2))
                            Text("Natália Dal Pizzol")
                                .font(.typography(.body2))
                            Text("Sofia Sartori")
                                .font(.typography(.body2))
                        }
                    }
                    .foregroundStyle(Color.tibbyBaseBlack)
                    Spacer()
                }
                .padding(.top, 16)
            }
            .padding(16)
            Spacer()
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(.tibbyBaseWhite)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SettingsView()
}
