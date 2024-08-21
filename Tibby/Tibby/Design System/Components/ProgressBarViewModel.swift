//
//  ProgressBarViewModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 21/08/24.
//

import Foundation
import SwiftUI

final class ProgressBarViewModel: ObservableObject {
    
    func getProgressWidth(progress: Double) -> CGFloat {
        return CGFloat(progress) / 100 * 60
    }
    
    func getProgressColor(progress: Double) -> Color {
        if progress > 60 {
            return Color.tibbyBaseSaturatedGreen
        }
        if progress > 30 {
            return Color.tibbyBaseSaturatedYellow
        }
        return Color.tibbyBaseRed
    }
    
}
