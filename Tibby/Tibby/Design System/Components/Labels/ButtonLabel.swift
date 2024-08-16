//
//  ButtonLabel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/08/24.
//

import SwiftUI

/// Defines the different types of buttons available in the Tibby app.
enum ButtonType {
    case primary, secondary, tertiary, tabBar
}

/// A customizable label for buttons in the Tibby app.
///
/// `ButtonLabel` provides an image and optional text, styled according to the button type.
struct ButtonLabel: View {
    /// The type of button, which determines the label's style.
    var type: ButtonType
    
    /// The name of the image to display in the button label.
    var image: String
    
    /// The text to display next to the image (used for primary buttons).
    var text: String
    
    /// The color of the text and image.
    var foregroundColor: Color = .tibbyBaseDarkBlue
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
            if type == .primary {
                Text(text)
                    .font(.typography(.title))
                    .padding(.leading, 32)
            } else {
                EmptyView()
            }
        }
        .foregroundStyle(foregroundColor)
    }
}
