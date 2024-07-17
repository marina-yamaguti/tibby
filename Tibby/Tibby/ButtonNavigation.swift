//
//  ButtonNavigation.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 17/07/24.
//

import SwiftUI

struct ButtonNavigation: ButtonStyle {
    let cointainerBackgroundColor: Color = .tibbyBaseBlue
    let cointainerStrokeColor: Color = .tibbyBaseBlack

    /// Create the button body with the specified style
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
        Rectangle()
            .foregroundStyle(cointainerBackgroundColor)
            .frame(width: 85, height: 85)
            .withBorderRadius(20)

    }
}


