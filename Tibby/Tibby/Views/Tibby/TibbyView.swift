//
//  TibbyView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 27/06/24.
//

import Foundation
import SpriteKit

extension SKScene: ObservableObject {}

class TibbyView: SKScene {
    
    private var tibby: SKSpriteNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {

        self.backgroundColor = .clear
        
        let w = (self.size.width + self.size.height) * 0.2
        self.tibby = SKSpriteNode(imageNamed: "MagnusTower")
        self.tibby.size = CGSize(width: w, height: w)
        self.tibby.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.tibby.position = CGPoint(x: 0.5, y: 0.5)
        self.tibby.name = "Tibby"
        
        addChild(tibby)
    }
    
}
