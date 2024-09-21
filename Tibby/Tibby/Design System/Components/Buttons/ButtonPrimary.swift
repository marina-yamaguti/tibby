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
    /// The color used for the shadow effect beneath the button.
    var shadowColor: Color = .tibbyBackgroundShadowGreen
    
    /// The background color of the button.
    var bgColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundStyle(determineForegroundColor(for: bgColor))
            .frame(minWidth: 175)
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(bgColor)  // Fill background color
                    .overlay(GradientBackgroundView(cornerRadius: 20))  // Apply overlay to background
                    .overlay(  // Add stroke as an overlay
                        RoundedRectangle(cornerRadius: 20, style: .circular)
                            .stroke(determineForegroundColor(for: bgColor), lineWidth: 2)  // Stroke applied separately
                    )
            }
            .padding(.bottom, configuration.isPressed ? 0 : 12)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(bgColor)
                    .strokeBorder(determineForegroundColor(for: bgColor), lineWidth: 2)
                    .brightness(-0.7)
                    .overlay(GradientBackgroundView(cornerRadius: 20))

            }
            .padding(.top, configuration.isPressed ? 20 : 0)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                HapticManager.instance.impact(style: .soft)
                AudioManager.instance.playSFX(audio: .primaryButton)
            }
    }
    
    func determineForegroundColor(for bgColor: Color) -> Color {
            switch bgColor {
            case .tibbyBaseBlue:
                return .tibbyBaseDarkBlue
            case .tibbyBaseYellow:
                return .tibbyBaseOlive
            default:
                return .black
            }
        }
}

