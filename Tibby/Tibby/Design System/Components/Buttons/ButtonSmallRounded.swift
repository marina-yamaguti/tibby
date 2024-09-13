//
//  ButtonSmallRounded.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/09/24.
//

import SwiftUI

struct ButtonSmallRounded: ButtonStyle {
    /// The background color of the button.
    var bgColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(width: 10, height: 10)
            .padding(8)
            .background(
                Circle()
                    .fill(bgColor)
            )
            .animation(.linear(duration: 0), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                HapticManager.instance.impact(style: .soft)
                AudioManager.instance.playSFX(audio: .secondaryButton)
            }
        
    }
}
