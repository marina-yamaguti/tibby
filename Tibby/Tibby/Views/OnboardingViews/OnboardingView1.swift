//
//  OnboardingView1.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//

import SwiftUI

struct OnboardingView1: View {
    
    @EnvironmentObject var constants: Constants
    
    var body: some View {
        VStack {
            Text("Hi, welcome!")
                .font(.typography(.title))
                .foregroundStyle(.tibbyBaseBlack)
            Text("small explanation about tibby,\nwellbeing app, promote good\nhabits with a companion.")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
            Rectangle()
                .frame(width: 150, height: 150)
            Button(action: {
                constants.currentOnboarding = .onboarding2
                constants.onboardingVisited[1] = true
            }, label: {
                Text("Next")
                    .font(.typography(.title))
            })
            .buttonPrimary(bgColor: .tibbyBaseBlue)
            .foregroundStyle(.tibbyBaseRed)
        }
    }
}

