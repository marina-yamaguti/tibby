//
//  SettingsComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import SwiftUI

/// Enum representing the type of trailing content in the settings component.
enum TrailingType {
    case toggleButton
    case details
}

/// A reusable SwiftUI component for displaying a settings option with either a toggle button or details view.
struct SettingsComponent: View {
    @EnvironmentObject var constants: Constants
    var trailingType: TrailingType
    
    /// The title displayed next to the circle.
    var title: String
    
    /// The label for the toggle or details section.
    var label: String
    
    /// The color of the circle next to the title.
    var color: Color
    
    var body: some View {
        VStack(spacing: 16) {
            // Header section with a colored circle and title
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 20, height: 20)
                Text(title)
                    .font(.typography(.label))
                    .foregroundStyle(Color.tibbyBaseBlack)
                Spacer()
            }
            
            // Trailing content: either a toggle or details view
            HStack {
                if trailingType == .details {
                    HStack {
                        Text(label)
                            .font(.typography(.body))
                            .foregroundStyle(.tibbyBaseBlack)
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
                    switch label {
                    case "Music":
                        Toggle(label, isOn: $constants.music)
                            .font(.typography(.body2))
                            .foregroundStyle(.tibbyBaseBlack)
                            .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 24))
                    case "Phone Vibration":
                        Toggle(label, isOn: $constants.vibration)
                            .font(.typography(.body2))
                            .foregroundStyle(.tibbyBaseBlack)
                            .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 24))
                    default:
                        EmptyView()
                    }
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.tibbyBasePearlBlue)
            }
        }
    }
}
