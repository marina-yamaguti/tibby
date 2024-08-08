//
//  NavigationButton.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/08/24.
//

import Foundation
import SwiftUI

struct TabBarButton: ButtonStyle {
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
                                .black)
                    }
            )
            .padding(.top, configuration.isPressed ? 20 : 0)
            .animation(.linear(duration: 0), value: configuration.isPressed)
        
        
    }
}
