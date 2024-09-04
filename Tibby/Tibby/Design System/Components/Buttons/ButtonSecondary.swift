//
//  ButtonSecondary.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/08/24.
//

import Foundation
import SwiftUI

/// A custom button style used for secondary buttons in the Tibby app.
/// This style applies a circular background with a semi-transparent color and includes a simple animation when the button is pressed.
struct ButtonSecondary: ButtonStyle {
    @EnvironmentObject var constants: Constants
    
    
    /// The background color of the button.
    var bgColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(width: 20, height: 20)
            .padding(10)
            .background(
                Circle()
                    .fill(bgColor.opacity(0.5))
            )
            .animation(.linear(duration: 0), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                HapticManager.instance.impact(style: .soft)
                AudioManager.instance.playSFX(audio: .secondaryButton)
            }
        
    }
}
