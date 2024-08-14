//
//  ButtonLabel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/08/24.
//

import SwiftUI

enum ButtonType {
    case primary, secondary, tertiary, tabBar
}

struct ButtonLabel: View {
    var type: ButtonType
    var image: String
    var text: String
    var foregroundColor: Color = .tibbyBaseDarkBlue
    var body: some View {
        HStack {
            Image(image)
            if type == .primary {
                Text(text)
                    .font(.typography(.title))
                    .padding(.leading, 32)
            }
        }
        .foregroundStyle(foregroundColor)
    }
}

#Preview {
    ButtonLabel(type: .primary, image: TibbySymbols.play.rawValue, text: "Play")
}
