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
    /// Binding to the toggle state. Used when `trailingType` is `.toggleButton`.
    @Binding var isOn: Bool
    
    /// Specifies the type of trailing content (`toggleButton` or `details`).
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
                Spacer()
            }
            
            // Trailing content: either a toggle or details view
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
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.tibbyBaseBlack)
            }
        }
    }
}
