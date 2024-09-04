//
//  OnboardingView1.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//

import SwiftUI

import SwiftUI

struct OnboardingView1: View {
    @State private var showFirstImage = true
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            
            ZStack {
                if showFirstImage {
                    Image("Onboarding1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .animation(.linear(duration: 0.5), value: showFirstImage)

                } else {
                    Image("Onboarding1-2")
                        .resizable()
                        .scaledToFit()
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

#Preview {
    OnboardingView1()
}


