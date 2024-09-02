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
    @State var input: String = ""
    
    /// The prompt displayed above the text field, indicating what the user should enter.
    var prompt: String
    
    /// The placeholder text displayed inside the text field when it is empty.
    var placeholder: String
    
    var body: some View {
        VStack {
            Text("Name")
                .foregroundStyle(.tibbyBaseBlack)
            TextField(placeholder, text: $input)
            Divider()
        }
        .font(.typography(.label))
    }
}
