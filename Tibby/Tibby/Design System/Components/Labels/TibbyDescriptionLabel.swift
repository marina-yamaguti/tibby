//
//  TibbyDescriptionLabel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

struct TibbyDescriptionLabel: View {
    @State var description: String
    @State var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("description")
                .font(.typography(.title))
            HStack(spacing: 4) {
                Text(description)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .font(.typography(FontStyle.body))
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(
                GeometryReader { geometry in
                    Rectangle()
                        .foregroundColor(color)
                        .opacity(0.5)
                        .cornerRadius(20)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            )
        }
    }
}

#Preview {
    TibbyDescriptionLabel(description: "Despite his fearsome appearance, Shark loves making new friends and exploring the underwater world. With sharp fins and a swift tail, he can glide through the ocean with grace and agility.", color: Color.tibbyBaseBlue)
}
