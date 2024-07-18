//
//  NeedsBarViewModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 17/07/24.
//

import Foundation
import SwiftUI

final class NeedsButtonViewModel: ObservableObject {
    func getProgressHeight(progress: Int) -> CGFloat {
        return CGFloat(progress) / 100 * 60
    }
    
    func getProgressColor(progress: Int) -> Color {
        if progress > 60 {
            return Color(.tibbyBaseGreen)
        }
        if progress > 30 {
            return Color(.tibbyBaseYellow)
        }
        return Color(.tibbyBaseRed)
    }
}
