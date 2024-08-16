//
//  button.swift
//  ButtonTest
//
//  Created by Natalia Dal Pizzol on 08/08/24.
//

import SwiftUI

/// A custom button style used for tertiary buttons in the Tibby app.
/// This style includes a rounded rectangle background, a subtle shadow effect, and a gradient overlay, with a simple animation when the button is pressed to create a refined, minimalistic look.
struct ButtonTertiary: ButtonStyle {
    
    /// The color used for the button's foreground elements, such as text or icons.
    var foregroundColor: Color = .white
    
    /// The background color of the button.
    var bgColor: Color = .tibbyBaseBlack
    
    /// The color used for the shadow effect beneath the button.
    var shadowColor: Color = .tibbyBackgroundShadowBlack
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(width: 1)
            .padding(EdgeInsets(top: 8, leading: 34, bottom: 8, trailing: 34))
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(bgColor)
                    .strokeBorder(foregroundColor.opacity(0.3), lineWidth: 0.5)
                
            }
            .padding(.bottom, configuration.isPressed ? 0 : 4)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(shadowColor)
            }
            .overlay(GradientBackgroundView(cornerRadius: 20))
            .padding(.top, configuration.isPressed ? 4 : 0)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
    }
}
