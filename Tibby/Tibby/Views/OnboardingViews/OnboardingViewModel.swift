//
//  OnboardingViewModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/08/24.
//

import SwiftUI
import SpriteKit

class OnboardingTabViewModel: SKScene, ObservableObject {
    @Published var onboardingViews: [OnboardingViews] = [.onboarding1, .onboarding2, .onboarding3, .onboarding4]
    @Published var currentIndex: Int = 0
    @Published var navigateToGatcha: Bool = false
    var animation: SKSpriteNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        // Clear the Scene background
        self.backgroundColor = .clear
        
        // Instantiate the Tibby node in the view as a square
        self.animation.size = CGSize(width: 1, height: 1)
        self.animation.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.animation.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(animation)
    }
    
    func generateAnimation(textureList: [String]) {
        // Get the assets name list to create the textures to animate
        var sprites: SKSpriteNode = SKSpriteNode()
        let group = DispatchGroup()
        group.enter()
        var textures: [SKTexture] = []
        for texture in textureList {
            group.enter()
            ImageHandler.shared.loadImage(urlString: texture) { image in
                if let image = image {
                    let texture = SKTexture(image: image)
                    textures.append(texture)
                    group.leave()
                } else {
                    //TODO: Handle the case where the image could not be loaded here
                    print("Failed to load image")
                    group.leave()
                }
            }
        }
        group.leave()
        group.notify(queue: .main) {
            // Create the animation from the textures list in the respective node
            let animation = SKAction.animate(with: textures, timePerFrame: 0.5)
            let repeatAnimation = SKAction.repeatForever(animation)
            sprites.run(repeatAnimation)
        }
    }

    var currentOnboarding: OnboardingViews {
        return onboardingViews[currentIndex]
    }
    
    func nextPage() {
        if currentIndex == 3 {
            UserDefaults.standard.set(false, forKey: "firstTime")
            navigateToGatcha = true
        } else {
            currentIndex += 1
        }
    }
    
    func previousPage() {
            currentIndex -= 1
    }
    
    func bodyContent(page: OnboardingViews) -> any View {
        switch currentIndex {
        case 0:
            OnboardingView1()
        case 1:
            OnboardingView2()
        case 2:
            OnboardingView3()
        case 3:
            OnboardingView4()
        default:
            OnboardingView1()
        }
    }
}
