//
//  TibbyDescriptionLabel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

/// TibbyDescriptionLabel is a SwiftUI view that displays a label with a description and a background color.
struct TibbyDescriptionLabel: View {
    /// The description text to be displayed, managed as a state variable
    @State var description: String
    
    /// The background color of the description label, managed as a state variable
    @State var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("description")
                .font(.typography(.body2))
                .foregroundStyle(Color.tibbyBaseBlack)
            HStack(spacing: 4) {
                Text(description)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .font(.typography(FontStyle.body2))//.font(.typography(FontStyle.label))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.tibbyBaseBlack)
            }
            .padding()
            .background(
                GeometryReader { geometry in
                    Rectangle()
                        .fill(color)
                        .cornerRadius(20)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            )
        }
    }
}
