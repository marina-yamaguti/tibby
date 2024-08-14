//
//  OnboardingModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/08/24.
//

import Foundation


enum OnboardingViews {
    case onboarding1, onboarding2, onboarding3, onboarding4
    
    var title: String {
        switch self {
        case .onboarding1: return "Hi, welcome!"
        case .onboarding2: return "Before you start"
        case .onboarding3: return "Tell us about yourself"
        case .onboarding4: return "So, to recap..."
        }
    }
    var description: String {
        switch self {
        case .onboarding1:
            return "small explanation about tibby, wellbeing app, promote good habits with a companion."
        case .onboarding2:
            return "small explanation about needing healthkit permission for the app to work. "
        case .onboarding3:
            return ""
        case .onboarding4:
            return ""
        }
    } 
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
    var buttonSymbol: String {
        switch self {
        case .onboarding1:
            return TibbySymbols.play.rawValue
        case .onboarding2:
            return TibbySymbols.play.rawValue
        case .onboarding3:
            return TibbySymbols.play.rawValue
        case .onboarding4:
            return TibbySymbols.play.rawValue
        }
    }
}

