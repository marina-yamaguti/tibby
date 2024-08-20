//
//  TibbyRarityLabel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

/// TibbyRarityLabel is a SwiftUI view that displays the rarity of a Tibby character.
struct TibbyRarityLabel: View {
    /// The rarity level of Tibby
    var rarity: Rarity
    /// The background color for the label
    var color: Color
    
    // Determines the color based on the rarity level
    private var rarityColor: Color {
        switch rarity {
        case .common:
            return Color.tibbyRarityCommon
        case .rare:
            return Color.tibbyRarityRare
        case .ultra:
            return Color.tibbyRarityUltra
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Rarity")
                .font(.typography(.body2))
                .foregroundStyle(Color.tibbyBaseBlack)
            HStack(spacing: 4) {
                Circle()
                    .frame(width: 27, height: 27)
                    .foregroundColor(rarityColor)
                    .saturation(2.0)
                Text(rarity.rawValue.lowercased())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .font(.typography(FontStyle.label))
                    .foregroundStyle(Color.tibbyBaseBlack)
                    .lineLimit(1)
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
