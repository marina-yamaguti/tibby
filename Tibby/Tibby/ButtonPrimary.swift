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
    let unpressedColor: Color = .blue
    let pressedColor: Color = .white

    /// Create the button body with the specified style
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .background(configuration.isPressed ? pressedColor : unpressedColor)
            .foregroundColor(configuration.isPressed ? unpressedColor : pressedColor)
    }
}
