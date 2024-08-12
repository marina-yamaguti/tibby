//
//  OnboardingView4.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//

import SwiftUI

struct OnboardingView4: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var healthManager: HealthManager
    @Binding var firstTime: Bool
    
    var body: some View {
        VStack {
            Text("So, to recap...")
                .font(.typography(.title))
                .foregroundStyle(.tibbyBaseBlack)
            
            Rectangle()
                .frame(width: 150, height: 150)
            
            HStack {
                Button(action: {
                    constants.currentOnboarding = .onboarding1
                    constants.onboardingVisited[3] = false
                }, label: {
                    Text("<")
                        .font(.typography(.title))
                })
                .buttonPrimary(bgColor: .tibbyBaseBlue)
                .foregroundStyle(.tibbyBaseGrey)
                
                Button(action: {
                    UserDefaults.standard.setValue(false, forKey: "firstTimeHere")
                    firstTime = false
                }, label: {
                    Text("Start")
                        .font(.typography(.title))
                })
                .buttonPrimary(bgColor: .tibbyBaseBlue)
                .foregroundStyle(.tibbyBaseYellow)
            }
        }
        .onAppear {
            healthManager.fetchAllInformation()
        }
    }
}

