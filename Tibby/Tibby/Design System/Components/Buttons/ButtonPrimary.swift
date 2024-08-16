//
//  ButtonPrimary.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 04/07/24.
//

import Foundation
import SwiftUI

/// A custom button style used for primary buttons in the Tibby app.
/// This style includes custom padding, background colors, shadows, and animations to create a prominent button design.
struct ButtonPrimary: ButtonStyle {
    
    /// The color used for the foreground elements of the button, such as the text or icon.
    var foregroundColor: Color = .tibbyBaseDarkBlue
    
    /// The color used for the shadow effect beneath the button.
    var shadowColor: Color = .tibbyBackgroundShadowGreen
    
    /// The background color of the button.
    var bgColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(EdgeInsets(top: 16, leading: 64, bottom: 16, trailing: 64))
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(bgColor)
                    .strokeBorder(foregroundColor, lineWidth: 2)
                
            }
            .padding(.bottom, configuration.isPressed ? 0 : 12)
            .animation(.linear(duration: 0), value: configuration.isPressed)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(shadowColor)
                    .strokeBorder(foregroundColor, lineWidth: 2)
            }
            .overlay(GradientBackgroundView(cornerRadius: 20))
            .padding(.top, configuration.isPressed ? 20 : 0)
            .animation(.linear(duration: 0), value: configuration.isPressed)
    }
}
