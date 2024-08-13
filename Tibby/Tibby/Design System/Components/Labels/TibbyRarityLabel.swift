//
//  TibbyRarityLabel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

struct TibbyRarityLabel: View {
    @State var rarity: Rarity
    var collection: Collection
    private var color: Color {
        switch collection {
        case .seaSeries:
            return Color.tibbyBaseBlue
        case .houseSeries:
            return Color.tibbyBasePink
        case .forestSeries:
            return Color.tibbyBaseGreen
        case .beachSeries:
            return Color.tibbyBaseOrange
        case .foodSeries:
            return Color.tibbyBaseRed
        case .urbanSeries:
            return Color.tibbyBaseGrey
        }
    }
    
    //when we have capsule assets, change to image of capsules
    private var rarityColor: Color {
        switch rarity {
        case .common:
            return Color.green
        case .rare:
            return Color.blue
        case .epic:
            return Color.purple
        }
    }
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .frame(width: 27, height: 27)
                .foregroundColor(rarityColor)
                .saturation(2.0)
            Text(rarity.rawValue.lowercased())
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

#Preview {
    TibbyRarityLabel(rarity: Rarity.common, collection: Collection.seaSeries)
}
