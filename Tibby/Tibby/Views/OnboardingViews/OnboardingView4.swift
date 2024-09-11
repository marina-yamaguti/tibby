//
//  OnboardingView4.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//

import SwiftUI


struct OnboardingView4: View {
    @EnvironmentObject var healthManager: HealthManager
    
    var body: some View {
        VStack {
            HStack {
                Image("CapsuleCommon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading) {
                    Text("Gatcha Fun")
                        .font(.typography(.body))
                    Text("Unlock new Tibbies through our exciting gacha system")
                        .font(.typography(.body2))
                }
                Spacer()
            }
            HStack {
                Image("CapsuleRare")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading) {
                    Text("Earn Rewards")
                        .font(.typography(.body))
                    Text("Complete missions and earn rewards like coins and items")
                        .font(.typography(.body2))
                }
                Spacer()

            }
            HStack {
                Image("CapsuleEpic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading) {
                    Text("Stay Healthy")
                        .font(.typography(.body))
                    Text("Track your workouts, steps, and more to keep both you and your Tibby in top shape!")
                        .font(.typography(.body2))
                }
                Spacer()
            }
            Spacer()
        }.foregroundStyle(.tibbyBaseBlack)
        .onAppear {
            healthManager.fetchAllInformation()
        }
    }
}

#Preview {
    OnboardingView4()
}
