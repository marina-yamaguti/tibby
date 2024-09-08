//
//  TextField.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/08/24.
//

import SwiftUI

/// A customizable text field component used in the Tibby app.
///
/// `CustomTextField` provides a text input field with a label, a placeholder, and a divider.
/// It is designed to be easily reused across the app, offering a consistent style and behavior.
struct CustomTextField: View {
    /// The text input provided by the user.
    @Binding var input: String
    
    /// The prompt displayed above the text field, indicating what the user should enter.
    var prompt: String
    
    /// The placeholder text displayed inside the text field when it is empty.
    var placeholder: String
    
    var body: some View {
        VStack {
            Text("How should we call you?")
                .font(.typography(.body2))
            TextField(placeholder, text: $input)
                .preferredColorScheme(.light)
                .font(.typography(.body2))
            Divider()
        }
        .font(.typography(.label))
        .foregroundStyle(.tibbyBaseBlack)

    }
}
