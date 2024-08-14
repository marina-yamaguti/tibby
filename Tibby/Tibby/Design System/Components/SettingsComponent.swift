//
//  SettingsComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import SwiftUI

enum TrailingType {
    case toggleButton, details
}

struct SettingsComponent: View {
    @State var isOn: Bool
    var trailingType: TrailingType
    var title: String
    var label: String
    var color: Color
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Circle()
                    .fill(.tibbyBaseRed)
                    .frame(width: 20, height: 20)
                Text(title)
                    .font(.typography(.label))
                Spacer()
            }
            HStack {
                if trailingType == .details {
                    HStack {
                        Text(label)
                            .font(.typography(.body))
                            .foregroundStyle(.tibbyBaseWhite)
                            .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 24))
                        Spacer()
                        HStack(alignment: .firstTextBaseline) {
                            Text("Detail")
                                .font(.typography(.label))
                            Image(systemName: "chevron.right")
                                .font(.caption2)
                                .fontWeight(.bold)
                        }
                        .foregroundStyle(.tibbyBaseGrey)
                        .padding(.trailing, 32)

                    }
                } else {
                    Toggle(label, isOn: $isOn)
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseWhite)
                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 24))
                }
            }
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .fill(.tibbyBaseBlack)
            }
        }
    }
}

#Preview {
    SettingsComponent(isOn: true, trailingType: .details, title: "Notifications", label: "Enable notifications", color: .tibbyBaseRed)
}
