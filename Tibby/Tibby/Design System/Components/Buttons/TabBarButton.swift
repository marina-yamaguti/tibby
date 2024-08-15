//
//  NavigationButton.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/08/24.
//

import Foundation
import SwiftUI

struct TabBarButton: ButtonStyle {
    var foregroundColor: Color = .tibbyBaseBlack
    var shadowColor: Color = .tibbyBaseBlack
    var bgColor: Color = .tibbyBaseWhite
    var overlayColor: Color = .tibbyBackgroundShadowGrey
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
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
            .overlay(GradientBackgroundView(bgColor: shadowColor, cornerRadius: 20))
            .padding(.top, configuration.isPressed ? 20 : 0)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
    }
}
