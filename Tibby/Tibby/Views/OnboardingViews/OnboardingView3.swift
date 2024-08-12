//
//  OnboardingView3.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//

import SwiftUI

struct OnboardingView3: View {
    @EnvironmentObject var constants: Constants
    @State var name = ""
    @State var exercise = ""
    @State var energy = ""
    @State var steps = ""
    
    var body: some View {
        VStack {
            Text("Tell us about\nyourself :)")
                .font(.typography(.title))
                .foregroundStyle(.tibbyBaseBlack)
                .padding()
            Text("Name")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.top)
            TextField(text: $name) {}
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.horizontal, 50)
            
            Text("Daily Exercise")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.top)
            TextField(text: $exercise) {}
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.horizontal, 50)
            
            Text("Daily Energy Goal")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.top)
            TextField(text: $energy) {}
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.horizontal, 50)
            
            Text("Daily Steps")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.top)
            TextField(text: $steps) {}
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.horizontal, 50)
            HStack {
                Button(action: {
                    constants.currentOnboarding = .onboarding2
                    constants.onboardingVisited[2] = false
                }, label: {
                    Text("<")
                        .font(.typography(.title))
                })
                .buttonPrimary(bgColor: .tibbyBaseBlue)
                .foregroundStyle(.tibbyBaseGrey)
                
                Button(action: {
                    constants.currentOnboarding = .onboarding4
                    constants.onboardingVisited[3] = true
                }, label: {
                    Text("Next")
                        .font(.typography(.title))
                })
                .buttonPrimary(bgColor: .tibbyBaseBlue)
                .foregroundStyle(.tibbyBaseYellow)
            }
            .padding(.top, 50)
        }
    }
}
