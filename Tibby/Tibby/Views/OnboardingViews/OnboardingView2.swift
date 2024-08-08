//
//  OnboardingView2.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//

import SwiftUI

struct OnboardingView2: View {
    
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var healthManager: HealthManager
    
    var body: some View {
        VStack {
            Text("Before you start")
                .font(.typography(.title))
                .foregroundStyle(.tibbyBaseBlack)
            Text("small explanation about needing\nhealthkit permission for the app to\nwork.")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
            Rectangle()
                .frame(width: 150, height: 150)
            HStack {
                Button(action: {
                    constants.currentOnboarding = .onboarding1
                    constants.onboardingVisited[1] = false
                }, label: {
                    Text("<")
                        .font(.typography(.title))
                })
                .buttonPrimary()
                .foregroundStyle(.tibbyBaseGrey)
                
                Button(action: {
                    healthManager.authorizationToWriteInHealthStore()
                    constants.currentOnboarding = .onboarding3
                    constants.onboardingVisited[2] = true
                }, label: {
                    Text("Next")
                        .font(.typography(.title))
                })
                .buttonPrimary()
                .foregroundStyle(.tibbyBaseYellow)
                
                
            }
        }
    }
}

