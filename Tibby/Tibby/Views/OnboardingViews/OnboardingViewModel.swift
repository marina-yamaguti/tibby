//
//  OnboardingViewModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/08/24.
//

import SwiftUI

class OnboardingTabViewModel: ObservableObject {
    @Published var onboardingViews: [OnboardingViews] = [.onboarding1, .onboarding2, .onboarding3, .onboarding4]
    @Published var currentIndex: Int = 0
    @Published var navigateToGatcha: Bool = false

    var currentOnboarding: OnboardingViews {
        return onboardingViews[currentIndex]
    }
    
    func nextPage() {
        if currentIndex == 3 {
            navigateToGatcha = true
        } else {
            currentIndex += 1
        }
    }
    
    func previousPage() {
            currentIndex -= 1
    }
    
//    func bodyContent(page: OnboardingViews) -> any View {
//        switch currentIndex {
//        case 0:
//            OnboardingView1()
//        case 1:
//            OnboardingView2()
//        case 2:
//            OnboardingView3()
//        case 3:
//            OnboardingView4()
//        default:
//            OnboardingView1()
//        }
//    }
}
