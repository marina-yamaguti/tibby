//
//  OnboardingViewModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/08/24.
//

import SwiftUI

class OnboardingTabViewModel: ObservableObject {
    @Published var onboardingViews: [OnboardingViews] = [.onboarding1, .onboarding2, .onboarding3, .onboarding4, .gacha]
    @Published var currentIndex: Int = 0
    //@Published var navigateToGatcha: Bool = false

    var currentOnboarding: OnboardingViews {
        return onboardingViews[currentIndex]
    }
    
    func nextPage() {
        if currentIndex <= 4 {
            currentIndex += 1
        }
    }
    
    func previousPage() {
            currentIndex -= 1
    }
}
