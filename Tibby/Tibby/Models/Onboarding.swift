//
//  OnboardingModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/08/24.
//

import Foundation

/// Enum representing the different views in the onboarding process.
enum OnboardingViews: CaseIterable {
    case onboarding1, onboarding2, onboarding3, onboarding4, gacha
    
    /// The title for the onboarding view.
    var title: String {
        switch self {
        case .onboarding1: return "Hi, welcome!"
        case .onboarding2: return "Before you start"
        case .onboarding3: return "Tell us about yourself"
        case .onboarding4: return "So, to recap..."
        case .gacha: return ""
        }
    }
    
    /// The description for the onboarding view.
    var description: String {
        switch self {
        case .onboarding1:
            return "Tibby will be your next best partner on keeping your habits up to date."
        case .onboarding2:
            return "Allow Health access to let Tibby help you achieve a healthier lifestyle with personalized care and activity tracking."
        case .onboarding3:
            return ""
        case .onboarding4:
            return ""
        case .gacha:
            return ""
        }
    }
    
    /// The label for the button in the onboarding view.
    var buttonLabel: String {
        switch self {
        case .onboarding1:
            return "Next"
        case .onboarding2:
            return "Accept"
        case .onboarding3:
            return "Save"
        case .onboarding4:
            return "Start"
        case .gacha:
            return ""
        }
    }
    
    /// The symbol for the button in the onboarding view.
    var buttonSymbol: String {
        switch self {
        case .onboarding1:
            TibbySymbols.chevronRightBlack.rawValue
        case .onboarding2:
            TibbySymbols.lockBlack.rawValue
        case .onboarding3:
            TibbySymbols.diskDark.rawValue
        case .onboarding4:
            TibbySymbols.playBlack.rawValue
        case .gacha:
            ""
        }
    }
}
