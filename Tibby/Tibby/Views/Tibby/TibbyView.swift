//
//  TibbyView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 27/06/24.
//

import Foundation
import SpriteKit

extension SKScene: ObservableObject {}

protocol TibbyProtocol {
    var tibby: SKSpriteNode { get set }
    var accessory: SKSpriteNode { get set }
    
    func addAccessory(_ imageName: String)
    func removeAccessory()
    func animateTibby()
}

class TibbyView: SKScene, TibbyProtocol {
    
    var tibby: SKSpriteNode = SKSpriteNode()
    var accessory: SKSpriteNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {

        self.backgroundColor = .clear
        
        let w = (self.size.width + self.size.height) * 0.2
        self.tibby = SKSpriteNode(imageNamed: "MagnusTower")
        self.tibby.size = CGSize(width: w, height: w)
        self.tibby.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.tibby.position = CGPoint(x: 0.5, y: 0.5)
        self.tibby.name = "Tibby"
        self.addChild(tibby)
    }
    
    func addAccessory(_ imageName: String) {
        let w = (self.size.width + self.size.height) * 0.2
        self.removeAccessory()
        self.accessory = SKSpriteNode(imageNamed: imageName)
        self.accessory.size = CGSize(width: w, height: w)
        self.accessory.name = "Accessory"
        tibby.addChild(accessory)
    }
    
    func animateTibby() {
        //
    }
    
    func removeAccessory() {
        if let child = self.accessory as? SKSpriteNode {
            child.removeFromParent()
        }
    }
}
