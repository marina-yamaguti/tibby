//
//  CircleButton.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 18/07/24.
//

import SwiftUI

struct RoundButton: ButtonStyle {
    var isDisabled: Bool?
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundStyle(Color.tibbyBaseGrey)
            .padding()
        Rectangle()
            .foregroundColor(.tibbyBaseWhite)
            .frame(width: 50, height: 50)
            .cornerRadius(86)
            .opacity(isDisabled ?? false ? 0.25 : 100)
    }
}
