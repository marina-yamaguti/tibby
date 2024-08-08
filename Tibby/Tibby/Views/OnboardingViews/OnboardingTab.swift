//
//  OnboardingTab.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//

import SwiftUI

enum OnboardingScreens {
    case onboarding1, onboarding2, onboarding3, onboarding4
    
    func onboardColor() -> Color {
        switch self {
        case .onboarding1:
            return .tibbyBaseRed
        case .onboarding2:
            return .tibbyBaseYellow
        case .onboarding3:
            return .tibbyBaseGreen
        case .onboarding4:
            return .tibbyBaseBlue
        }
    }
}

struct OnboardingTab: View {
    
    @EnvironmentObject var constants: Constants
    @State var onboardingViews: [OnboardingScreens] = [.onboarding1, .onboarding2, .onboarding3, .onboarding4]
    @Binding var firstTime: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ForEach(0..<onboardingViews.count) { i in
                    Rectangle()
                        .frame(height: 20)
                        .foregroundStyle(constants.onboardingVisited[i] ? onboardingViews[i].onboardColor() : .tibbyBaseGrey)
                }
                Spacer()
            }
            .padding()
            switch constants.currentOnboarding {
            case .onboarding1:
                OnboardingView1()
            case .onboarding2:
                OnboardingView2()
            case .onboarding3:
                OnboardingView3()
            case .onboarding4:
                OnboardingView4(firstTime: $firstTime)
            }
            Spacer()
        }
        .background(.tibbyBaseWhite)
    }
}
