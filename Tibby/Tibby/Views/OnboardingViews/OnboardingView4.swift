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
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 60, height: 60)
                VStack {
                    Text("Small title")
                        .font(.typography(.label))
                    Text("important feature")
                        .font(.typography(.body))
                }
            }
            HStack {
                Circle()
                    .frame(width: 60, height: 60)
                VStack {
                    Text("Small title")
                        .font(.typography(.label))
                    Text("important feature")
                        .font(.typography(.body))
                }
            }
        }
        .onAppear {
            healthManager.fetchAllInformation()
        }
    }
}

