//
//  ButtonSecondary.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/08/24.
//

import Foundation
import SwiftUI

struct ButtonSecondary: ButtonStyle {
    var bgColor: Color = .black
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(8)
            .background(
                Circle()
                    .fill(bgColor.opacity(0.5))
            )
            .animation(.linear(duration: 0), value: configuration.isPressed)
        
        
    }
}

struct TestViewSecondary: View {
    var body: some View {
        Button(action: {}, label: {ButtonLabel(type: .secondary, image: Symbols.lightBulb.rawValue, text: "")})
            .buttonStyle(ButtonSecondary())
    }
}

#Preview {
    TestViewSecondary()
}
