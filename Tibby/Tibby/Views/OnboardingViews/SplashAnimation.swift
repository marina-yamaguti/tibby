//
//  SplashAnimation.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 19/09/24.
//

import SwiftUI

struct SplashAnimation: View {
    @State private var currentFrame = 1
    @State private var timer: Timer? = nil
    @State private var showLogo: Bool = false
    let totalFrames = 16

    var body: some View {
        ZStack {
            if !showLogo {
                backgroundColor(for: currentFrame)

                Image("splashAnimation\(currentFrame)")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 390)
                    .onAppear {
                        startAnimation()
                    }
                    .onDisappear {
                        stopAnimation()
                    }
            } else {
                Color.tibbyBaseBlue

                Image("splashAnimationLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 260)
            }
        }
        .ignoresSafeArea()
    }
    
    func backgroundColor(for frame: Int) -> Color {
        switch frame {
        case 15...16:
            return Color.tibbyBaseClear
        default:
            return Color.tibbyBaseBlue
        }
    }
    
    
    func startAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            withAnimation(.spring) {
                if currentFrame < totalFrames {
                    currentFrame += 1
                } else {
                    stopAnimation()
                    showLogo.toggle()
                    
                }
            }
        }
    }
    
    // Function to stop the animation and invalidate the timer
    func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }
}
