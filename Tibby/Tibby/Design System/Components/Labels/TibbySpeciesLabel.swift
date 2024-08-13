//
//  TibbyDetailsLabel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 08/08/24.
//

import SwiftUI

struct TibbySpeciesLabel: View {
    @State var species: String
    @State var color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("species")
                .font(.typography(.body2))
            HStack(spacing: 4) {
                Circle()
                    .frame(width: 27, height: 27)
                    .foregroundColor(color)
                    .saturation(2.0)
                Text(species)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .font(.typography(FontStyle.body))
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
    TibbySpeciesLabel(species: "shark", color: Color.tibbyBaseBlue)
}
