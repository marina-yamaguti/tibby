//
//  ButtonPrimary.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 04/07/24.
//

import Foundation
import SwiftUI

struct ButtonPrimary: ButtonStyle {
    /// Define colors for unpressed and pressed states
    let foregroundColorUnpressed: Color = .tibbyBaseBlack
    let foregroundColorPressed: Color = .tibbyBaseYellow
    let backgroundColor: Color = .tibbyBaseYellow

    /// Create the button body with the specified style
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .background(backgroundColor)
            .foregroundColor(configuration.isPressed ? foregroundColorPressed : foregroundColorUnpressed)
    }
}
