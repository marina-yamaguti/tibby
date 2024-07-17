//
//  TibbyView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 27/06/24.
//

import Foundation
import SpriteKit
import UIKit

class TibbyView: SKScene, TibbyProtocol {
    
    /// Represents the Nodes to appear in the Sprite View
    var tibby: SKSpriteNode = SKSpriteNode()
    var accessory: SKSpriteNode = SKSpriteNode()
    var tibbyObject: Tibby?
    var tibbySpecie: TibbySpecie?
    var petAnimation = false
    
    override func didMove(to view: SKView) {
        // Clear the Scene background
        self.backgroundColor = .clear
        
        // Instantiate the Tibby node in the view as a square
        self.tibby.size = CGSize(width: 1, height: 1)
        self.tibby.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.tibby.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.tibby.name = "Tibby"
        self.addChild(tibby)
        
        // Drag gesture recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        
        animateTibby((tibbyObject!.happiness > 33 || tibbyObject!.hunger > 33 || tibbyObject!.sleep > 33 ? tibbySpecie!.sadAnimation() : tibbySpecie!.baseAnimation()), nodeID: .tibby, timeFrame: 0.5)
    }
    
    func addAccessory(_ accessory: Accessory, _ service: Service, tibbyID: UUID?) {
        // Remove the former accessory from the tibby to add a new one (duplicate problem)
        self.removeAccessory(service)
        // Instantiate the Accessory node in the view as a square as a Tibby's child
        self.accessory = SKSpriteNode(imageNamed: accessory.image)
        self.accessory.size = CGSize(width: 1, height: 1)
        self.accessory.name = accessory.name
        tibby.addChild(self.accessory)
        // Add the accessory to the tibby in SwiftData
        if let tibbyID = tibbyID {
            service.addAccessoryToTibby(tibbyId: tibbyID, accessory: accessory)
        }
    }
    
    func animateTibby(_ textureList: [String], nodeID: NodeType, timeFrame: TimeInterval) {
        // Get the assets name list to create the textures to animate
        var textures: [SKTexture] = []
        for texture in textureList {
            textures.append(SKTexture(imageNamed: texture))
        }
        // Create the animation from the textures list in the respective node
        let animation = SKAction.animate(with: textures, timePerFrame: timeFrame)
        let repeatAnimation = SKAction.repeatForever(animation)
        if nodeID == .tibby {
            tibby.run(repeatAnimation)
        } else if nodeID == .accessory {
            accessory.run(repeatAnimation)
        }
    }
    
    func removeAccessory(_ service: Service) {
        // Remove the current accessory from the tibby from node and SwiftData
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
    
    func setTibby(tibbyObject: Tibby) {
        // Set the tibby to manage in the view
        self.tibbyObject = tibbyObject
    }
    
    func setTibbySpecie(tibbySpecie: TibbySpecie) {
        // Set the tibby specie to manage in the view
        self.tibbySpecie = tibbySpecie
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        gesture.setTranslation(.zero, in: view)
                
        let currentPosition = gesture.location(in: view)
        let newPosition = CGPoint(x: currentPosition.x + translation.x, y: currentPosition.y - translation.y)
        if currentPosition != newPosition {
            if petAnimation {
                animateTibby(tibbySpecie!.happyAnimation(), nodeID: .tibby, timeFrame: 0.5)
                // TODO: Aumentar a felicidade do Tibby usando a classe de serviço
                petAnimation = false
            }
            HapticManager.instance.impact(style: .soft)
        }
        else {
            petAnimation = true
            animateTibby((tibbyObject!.happiness > 33 || tibbyObject!.hunger > 33 || tibbyObject!.sleep > 33 ? tibbySpecie!.sadAnimation() : tibbySpecie!.baseAnimation()), nodeID: .tibby, timeFrame: 0.5)
        }
        
    }
}
