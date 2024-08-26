//
//  OnboardingAnimation.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 23/08/24.
//

import Foundation
import SpriteKit
import UIKit
import SwiftUI

class OnboardingAnimation: SKScene {
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
}
