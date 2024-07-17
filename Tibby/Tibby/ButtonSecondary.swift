//
//  ButtonSecondary.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 17/07/24.
//

import SwiftUI

struct ButtonSecondary: ButtonStyle {
    /// Create the button body with the specified style
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .tibbyBaseBlack : .tibbyBaseBlack)
            .padding()
            .background(.tibbyBaseBlue)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(configuration.isPressed ? .tibbyBaseBlue : .tibbyBaseBlack), lineWidth: 3)
            )
    }
}
