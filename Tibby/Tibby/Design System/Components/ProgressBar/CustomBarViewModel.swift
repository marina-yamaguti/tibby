//
//  CustomBarViewModel.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 22/08/24.
//

import Foundation
import SwiftUI

final class CustomBarViewModel: ObservableObject {
    func getProgressColor(progress: Double) -> Color {
        switch progress {
        case 0..<0.33:
            return Color.red
        case 0.33..<0.66:
            return Color.yellow
        case 0.66...1:
            return Color.green
        default:
            return Color.gray
        }
    }
    func getSegmentedProgressColor(segment: Int, progress: Double) -> Color {
        let segmentProgress = progress * 3 // Scale progress to 3 segments
        
        if Double(segment) < segmentProgress {
            if segmentProgress < 1 {
                return Color.red
            } else if segmentProgress < 2 {
                return Color.yellow
            } else {
                return Color.green
            }
        } else {
            return Color.black.opacity(0.5)
        }
    }
    
    func getText(value: Double, barType: ProgressBarType) -> String {
        switch barType {
        case .eat:
            switch value {
            case 0..<0.33:
                return "starving"
            case 0.33..<0.66:
                return "hungry"
            case 0.66...1:
                return "satisfied"
            default:
                return ""
            }
        case .sleep:
            switch value {
            case 0..<0.33:
                return "tired"
            case 0.33..<0.66:
                return "awake"
            case 0.66...1:
                return "energized"
            default:
                return ""
            }
        case .emotion:
            switch value {
            case 0..<0.33:
                return "sad"
            case 0.33..<0.66:
                return "neutral"
            case 0.66...1:
                return "happy"
            default:
                return ""
            }
        case .xp:
            return ""
            
        }
    }
}
