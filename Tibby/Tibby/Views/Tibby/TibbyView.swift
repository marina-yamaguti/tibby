//
//  TibbyView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 27/06/24.
//

import Foundation
import SpriteKit

class TibbyView: SKScene, TibbyProtocol {

    ///represents the Nodes to appear in the Sprite View
    var tibby: SKSpriteNode = SKSpriteNode()
    var accessory: SKSpriteNode = SKSpriteNode()
    var tibbyID: UUID?
    
    override func didMove(to view: SKView) {
        //clear the Scene background
        self.backgroundColor = .clear
        
        //instantiate the Tibby node in the view as a square
        self.tibby.size = CGSize(width: 1, height: 1)
        self.tibby.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.tibby.position = CGPoint(x: 0.5, y: 0.5)
        self.tibby.name = "Tibby"
        self.addChild(tibby)
    }
    
    func addAccessory(_ accessory: Accessory, _ service: Service, tibbyID: UUID?) {
        //remove the former accessory from the tibby to add a new one (duplicate problem)
        self.removeAccessory(service)
        //instantiate the Accessory node in the view as a square as a Tibby's child
        self.accessory = SKSpriteNode(imageNamed: accessory.image)
        self.accessory.size = CGSize(width: 1, height: 1)
        self.accessory.name = accessory.name
        tibby.addChild(self.accessory)
        //add the accessory to the tibby in SwiftData
        if let tibbyID = tibbyID {
            service.addAccessoryToTibby(tibbyId: tibbyID, accessory: accessory)
        }
    }
    
    func animateTibby(_ textureList: [String], nodeID: NodeType, timeFrame: TimeInterval) {
        //get the assets name list to create the textures to animate
        var textures: [SKTexture] = []
        for texture in textureList {
            textures.append(SKTexture(imageNamed: texture))
        }
        //create the animation from the textures list in the respective node
        let animation = SKAction.animate(with: textures, timePerFrame: timeFrame)
        let repeatAnimation = SKAction.repeatForever(animation)
        if nodeID == .tibby {
            tibby.run(repeatAnimation)
        }
        else if nodeID == .accessory {
            accessory.run(repeatAnimation)
        }
    }
    
    func removeAccessory(_ service: Service) {
        //remove the current accessory from the tibby from node and SwiftData
        var accessoryName = ""
        if let child = self.accessory as? SKSpriteNode {
            accessoryName = child.name ?? ""
            child.removeFromParent()
        }
        for accessory in service.getAllAccessories()! {
            if accessory.name == accessoryName {
                service.removeAccessoryFromTibby(accessory: accessory)
            }
        }
    }
    
    func setTibbyID(tibbyId: UUID) {
        //Set the tibby to manage in the view
        self.tibbyID = tibbyId
    }
}
