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
            return "Small explanation about Tibby, a wellbeing app that promotes good habits with a companion."
        case .onboarding2:
            return "Small explanation about needing HealthKit permission for the app to work."
        case .onboarding3:
            return "Tell us a little about yourself to help personalize your experience."
        case .onboarding4:
            return "Let's recap the key points before we start!"
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
