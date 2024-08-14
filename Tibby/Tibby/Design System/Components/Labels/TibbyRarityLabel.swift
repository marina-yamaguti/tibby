//
//  TibbyRarityLabel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

struct TibbyRarityLabel: View {
    @State var rarity: Rarity
    @State var color: Color
    //when we have capsule assets, change to image of capsules
    private var rarityColor: Color {
        switch rarity {
        case .common:
            return Color.tibbyRarityCommon
        case .rare:
            return Color.tibbyRarityRare
        case .epic:
            return Color.tibbyRarityEpic
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("rarity")
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
    TibbyRarityLabel(rarity: Rarity.common, color: Color.tibbyBaseBlue)
}
