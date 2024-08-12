//
//  button.swift
//  ButtonTest
//
//  Created by Natalia Dal Pizzol on 08/08/24.
//

import SwiftUI

struct ButtonTertiary: ButtonStyle {
    var foregroundColor: Color = .white
    var bgColor: Color = .tibbyBaseBlack
    var shadowColor: Color = .tibbyBackgroundShadowGreen
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(EdgeInsets(top: 12, leading: 60, bottom: 12, trailing: 60))
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(bgColor)
                    .strokeBorder(foregroundColor.opacity(0.3), lineWidth: 0.5)
                
            }
            .padding(.bottom, configuration.isPressed ? 0 : 4)
            .animation(.linear(duration: 0), value: configuration.isPressed)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(shadowColor)
            }
            .overlay(GradientBackgroundView(bgColor: bgColor, cornerRadius: 20))
            .padding(.top, configuration.isPressed ? 4 : 0)
            .animation(.linear(duration: 0), value: configuration.isPressed)
    }
}

struct TertiaryTestView: View {
    var body: some View {
        Button {
        } label: {
            HStack(spacing: 24) {
                Text("")
            }
        }
        .buttonStyle(ButtonTertiary())
    }
}
#Preview {
    TertiaryTestView()
}
