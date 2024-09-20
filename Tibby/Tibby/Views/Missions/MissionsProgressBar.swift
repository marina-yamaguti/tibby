//
//  MissionsProgressBar.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 11/09/24.
//

import Foundation
import SwiftUI


struct MissionsProgressBar: ProgressViewStyle {
    var height = 20.0
    var totalValue: Int
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.tibbyBaseWhite)
                    .frame(height: CGFloat(height))
                
                Capsule()
                    .fill(.tibbyBaseSaturatedGreen)
                    .frame(width: geometry.size.width * CGFloat(fractionCompleted), height: CGFloat(height))
                
                // Progress percentage text
                Text("\(Int(fractionCompleted * Double(totalValue))) / \(totalValue)")
                    .font(.typography(.label))
                    .foregroundColor(.tibbyBaseDarkBlue)
                    .frame(width: geometry.size.width, alignment: .center)
            }
        }
    }
}
