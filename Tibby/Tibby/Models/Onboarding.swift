//
//  OnboardingModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/08/24.
//

import Foundation

/// Enum representing the different views in the onboarding process.
enum OnboardingViews: CaseIterable {
    case onboarding1, onboarding2, onboarding3, onboarding4
    
    /// The title for the onboarding view.
    var title: String {
        switch self {
        case .onboarding1: return "Hi, welcome!"
        case .onboarding2: return "Before you start"
        case .onboarding3: return "Tell us about yourself"
        case .onboarding4: return "So, to recap..."
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
            return "How should we call you?"
        case .onboarding4:
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
            return "Conclude"
        case .onboarding4:
            return "Start"
        }
    }
    
    /// The symbol for the button in the onboarding view.
    var buttonSymbol: String {
        return TibbySymbols.play.rawValue
    }
}
