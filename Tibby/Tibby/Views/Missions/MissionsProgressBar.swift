//
//  MissionsProgressBar.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 11/09/24.
//

import Foundation
import SwiftUI


import SwiftUI

struct MissionsProgressBar: ProgressViewStyle {
    var height: CGFloat = 20.0
    var totalValue: Int
    var minProgressWidth: CGFloat = 3.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.tibbyBaseWhite)
                    .frame(height: height)

                Text(progressText(fractionCompleted))
                    .font(.typography(.label))
                    .foregroundColor(.tibbyBaseDarkBlue)
                    .frame(maxWidth: .infinity, alignment: .center)

                Capsule()
                    .fill(.tibbyBaseSaturatedGreen)
                    .frame(
                        width: max(geometry.size.width * CGFloat(fractionCompleted), minWidth(fractionCompleted, geometry.size.width)),
                        height: height
                    )
                    .animation(.easeInOut(duration: 0.3), value: fractionCompleted)
            }
        }
        .frame(height: height)
    }

    private func progressText(_ fractionCompleted: Double) -> String {
        let currentValue = Int(fractionCompleted * Double(totalValue))
        return "\(currentValue) / \(totalValue)"
    }

    private func minWidth(_ fractionCompleted: Double, _ totalWidth: CGFloat) -> CGFloat {
        return fractionCompleted > 3.0 ? minProgressWidth : 0
    }
}

#Preview {
    ProgressView(value: 0.01, total: 1.0)
        .progressViewStyle(MissionsProgressBar(totalValue: 100))
        .padding()
}
