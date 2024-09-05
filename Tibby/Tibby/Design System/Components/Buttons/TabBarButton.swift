//
//  NavigationButton.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/08/24.
//

import Foundation
import SwiftUI

/// A custom button style used for tab bar buttons in the Tibby app.
/// The button style includes custom padding, background colors, shadows, and animations to provide a distinctive look and feel.
struct TabBarButton: ButtonStyle {
    @EnvironmentObject var constants: Constants
    
    /// The color used for the foreground elements of the button, such as the text or icon.
    var foregroundColor: Color = .tibbyBaseBlack
    
    /// The color used for the shadow effect beneath the button.
    var shadowColor: Color = .tibbyBaseBlack
    
    /// The background color of the button.
    var bgColor: Color = .tibbyBaseWhite
    
    /// The overlay color applied when the button is pressed.
    var overlayColor: Color = .tibbyBackgroundShadowGrey
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(width: 30, height: 30)

            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(configuration.isPressed ? overlayColor : bgColor)
                    .strokeBorder(foregroundColor, lineWidth: 2)
            }
            .padding(.bottom, configuration.isPressed ? 0 : 12)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(shadowColor)
                    .strokeBorder(foregroundColor, lineWidth: 2)
            }
            .overlay(GradientBackgroundView(cornerRadius: 20))
            .padding(.top, configuration.isPressed ? 20 : 0)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                HapticManager.instance.impact(style: .soft)
                AudioManager.instance.playSFX(audio: .primaryButton)
            }
    }
}
