//
//  ButtonPrimary.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 04/07/24.
//

import Foundation
import SwiftUI

struct ButtonPrimary: ButtonStyle {
    /// Create the button body with the specified style
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(EdgeInsets(top: 14, leading: 24, bottom: 14, trailing: 24))
            .background {
                RoundedRectangle(cornerRadius: 17, style: .circular)
                    .strokeBorder(.black ,lineWidth: 4)
                    .background {
                        RoundedRectangle(cornerRadius: 17, style: .circular)
                            .fill(.linearGradient(.init(colors: [.cyan, Color(uiColor: .yellow)]), startPoint: .leading, endPoint: .trailing))
                    }
            }
            .padding(.bottom, configuration.isPressed ? 0 : 12)
            .animation(.linear(duration: 0), value: configuration.isPressed)
            .background(
                RoundedRectangle(cornerRadius: 17, style: .circular)
                    .strokeBorder(configuration.isPressed ? .black : .black ,lineWidth: 4)
                    .background {
                        RoundedRectangle(cornerRadius: 17, style: .circular)
                            .fill(
                                LinearGradient(
                                stops: [
                                Gradient.Stop(color: .white.opacity(0.3), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.53, green: 0.53, blue: 0.53).opacity(0), location: 0.50),
                                Gradient.Stop(color: .black.opacity(0.3), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0, y: 0.5),
                                endPoint: UnitPoint(x: 1, y: 0.5)
                                )
                            )
                    }
            )
            .padding(.top, configuration.isPressed ? 20 : 0)
            .animation(.linear(duration: 0), value: configuration.isPressed)


    }
    
}

