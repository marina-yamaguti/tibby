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
    var tibbyID: UUID? { get set }
    var textures: [SKTexture] { get set }
    
    func addAccessory(accessory: Accessory, service: Service, tibbyID: UUID?)
    func removeAccessory(accessory: Accessory, service: Service)
    func animateTibby()
    func setTibbyID(tibbyId: UUID)
}

class TibbyView: SKScene, TibbyProtocol {
    
    var tibby: SKSpriteNode = SKSpriteNode()
    var accessory: SKSpriteNode = SKSpriteNode()
    var tibbyID: UUID?
    var textures: [SKTexture] = [SKTexture(imageNamed: "shark1"), SKTexture(imageNamed: "shark2")]
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .clear
        
        self.tibby = SKSpriteNode(texture: textures.first)
        self.tibby.size = CGSize(width: 1, height: 1)
        self.tibby.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.tibby.position = CGPoint(x: 0.5, y: 0.5)
        self.tibby.name = "Tibby"
        self.addChild(tibby)
        self.animateTibby()
    }
    
    func addAccessory(accessory: Accessory, service: Service, tibbyID: UUID?) {
        self.removeAccessory(accessory: accessory, service: service)
        self.accessory = SKSpriteNode(imageNamed: accessory.image)
        self.accessory.size = CGSize(width: 1, height: 1)
        self.accessory.name = "Accessory"
        tibby.addChild(self.accessory)
        if let tibbyID = tibbyID {
            service.addAccessoryToTibby(tibbyId: tibbyID, accessory: accessory)
        }
    }
    
    func animateTibby() {
        let animation = SKAction.animate(with: textures, timePerFrame: 0.5)
        let repeatAnimation = SKAction.repeatForever(animation)
        tibby.run(repeatAnimation)
    }
    
    func removeAccessory(accessory: Accessory, service: Service) {
        if let child = self.accessory as? SKSpriteNode {
            child.removeFromParent()
        }
        service.removeAccessoryFromTibby(accessory: accessory)
    }
    
    func setTibbyID(tibbyId: UUID) {
        self.tibbyID = tibbyId
    }
}
