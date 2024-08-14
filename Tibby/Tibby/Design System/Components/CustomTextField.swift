//
//  TextField.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/08/24.
//

import SwiftUI

struct CustomTextField: View {
    @State var input: String = ""
    var prompt: String
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
    

#Preview {
    CustomTextField(prompt: "How should we call you?", placeholder: "Name")
}
