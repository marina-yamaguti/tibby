//
//  ButtonLabel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/08/24.
//

import SwiftUI

struct ButtonLabel: View {
    var image: String
    var text: String
    var body: some View {
        HStack(spacing: 24) {
            Image(image)
            Text(text)
                .font(.typography(.title))
        }
        .foregroundStyle(.tibbyBaseBlack)
    }
}

#Preview {
    ButtonLabel(image: Symbols.play.rawValue, text: "Play")
}
