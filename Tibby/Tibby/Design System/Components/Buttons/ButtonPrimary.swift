//
//  ButtonPrimary.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 04/07/24.
//

import Foundation
import SwiftUI

struct ButtonPrimary: ButtonStyle {
    var foregroundColor: Color = .tibbyBaseDarkBlue
    var shadowColor: Color = .tibbyBackgroundShadowGreen
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
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(shadowColor)
                    .strokeBorder(foregroundColor, lineWidth: 2)
            }
            .overlay(GradientBackgroundView(bgColor: bgColor, cornerRadius: 20))
            .padding(.top, configuration.isPressed ? 20 : 0)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
    }
}
