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
    
    @State private var showFirstImage = true
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            
            ZStack {
                if showFirstImage {
                    Image("Onboarding2")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(1.5)
                        .frame(width: 200, height: 200)
                        .animation(.linear(duration: 0.5), value: showFirstImage)

                } else {
                    Image("Onboarding2-2")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(1.5)
                        .frame(width: 200, height: 200)
                        .animation(.linear(duration: 0.5), value: showFirstImage)

                }
            }
        }
        .onReceive(timer) { _ in
            showFirstImage.toggle()
        }
    }
}
