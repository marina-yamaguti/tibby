//
//  ButtonPrimary.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 04/07/24.
//

import Foundation
import SwiftUI

struct ButtonPrimary: ButtonStyle {
    /// Create the button body with the specified style
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.typography(.title))
            .foregroundStyle(Color.tibbyBaseBlack)
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            .background(.tibbyBaseBlue)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(configuration.isPressed ? .tibbyBaseBlue : .tibbyBaseBlack), lineWidth: 3)
            )
    }
}
