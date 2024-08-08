//
//  NavigationButton.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/08/24.
//

import SwiftUI

struct NavigationButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
            .background {
                RoundedRectangle(cornerRadius: 50, style: .circular)
                    .strokeBorder(.black ,lineWidth: 1)
                    .background {
                        RoundedRectangle(cornerRadius: 50, style: .circular)
                            .fill(
                                LinearGradient(
                                stops: [
                                Gradient.Stop(color: Color(red: 0.16, green: 0.17, blue: 0.22), location: 0.45),
                                Gradient.Stop(color: .black, location: 1.00),
                                ],
                                startPoint: UnitPoint(x: -0.06, y: -0.18),
                                endPoint: UnitPoint(x: 1, y: 1.4)
                                )
                            )
                    }
            }
            .padding(.bottom, configuration.isPressed ? 0 : 3)
            .animation(.linear(duration: 0), value: configuration.isPressed)
            .background(
                RoundedRectangle(cornerRadius: 50, style: .circular)
                    .strokeBorder(.blue ,lineWidth: 1)
                    .background {
                        RoundedRectangle(cornerRadius: 50, style: .circular)
                            .fill(.blue)
                    }
            )
            .padding(.top, configuration.isPressed ? 3 : 0)
            .animation(.linear(duration: 0), value: configuration.isPressed)


    }
    
}
