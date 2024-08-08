//
//  TibbyDetailsLabel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 08/08/24.
//

import SwiftUI

struct TibbyDetailsLabel: View {
    var species: String
    var collection: Collection
    private var circleColor: Color {
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
    

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .frame(width: 27, height: 27)
                .foregroundColor(circleColor)
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
                    .foregroundColor(Color.tibbyBaseLightGrey)
                    .opacity(0.5)
                    .cornerRadius(20)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        )
    }
}




#Preview {
    TibbyDetailsLabel(species: "shark", collection: Collection.seaSeries)
}
