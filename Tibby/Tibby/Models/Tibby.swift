//
//  Tibby.swift
//  Tibby
//
//  Created by Sofia Sartori on 26/06/24.
//

import Foundation
import SwiftData
import SpriteKit

///enum to represent the types of nodes in the SpriteKit View
enum NodeType {
    case tibby
    case accessory
}

/// A protocol for the Tibby View in SpriteKit to be operated in a SwiftUI View
protocol TibbyProtocol {
    
    // MARK: Tibby and accessory Nodes instances
    var tibby: SKSpriteNode { get set }
    var accessory: SKSpriteNode { get set }
    /// Tibby ID to operate in the view
    var tibbyID: UUID? { get set }
    func setTibbyID(tibbyId: UUID)
    
    ///Functions to add and remove accessory from the SpriteKit View and SwiftData only populating deleting the accessory reference
    func addAccessory(_ accessory: Accessory, _ service: Service, tibbyID: UUID?)
    func removeAccessory(_ service: Service)
    ///Pass the set of images for the animation and what is animating
    func animateTibby(_ textureList: [String], nodeID: NodeType, timeFrame: TimeInterval)
    
    ///Return the acnhor point of the sprite node of the Tibby
    func getTibbyPosition() -> CGPoint
}

/// A model representing a Tibby, a virtual pet with various attributes and states.
@Model
final class Tibby {
    
    /// The unique identifier for the Tibby.
    var id: UUID
    
    /// The unique identifier of the owner of the Tibby.
    var ownerId: UUID?
    
    /// The name of the Tibby.
    var name: String?
    
    /// The chance of getting this Tibby
    var rarity: String
    
    /// Additional details about the Tibby.
    var details: String
    
    /// The personality traits of the Tibby.
    var personality: String
    
    /// The species of the Tibby.
    var species: String
    
    /// The current level of the Tibby.
    var level: Int
    
    /// The experience points of the Tibby.
    var xp: Int
    
    /// The happiness level of the Tibby.
    var happiness: Int
    
    /// The hunger level of the Tibby.
    var hunger: Int
    
    /// The sleep level of the Tibby.
    var sleep: Int
    
    /// The friendship level of the Tibby with its owner.
    var friendship: Int
    
    /// The date when the Tibby was last updated.
    var lastUpdated: Date
    
    /// If this tibby is arealdy unlocked for the main User
    var isUnlocked: Bool
    
    /// Initializes a new Tibby with the specified attributes.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the Tibby.
    ///   - ownerId: The unique identifier of the owner of the Tibby.
    ///   - name: The name of the Tibby.
    ///   - rarity: The chance of getting this Tibby
    ///   - details: Additional details about the Tibby.
    ///   - personality: The personality traits of the Tibby.
    ///   - species: The species of the Tibby.
    ///   - level: The current level of the Tibby.
    ///   - xp: The experience points of the Tibby.
    ///   - happiness: The happiness level of the Tibby.
    ///   - hunger: The hunger level of the Tibby.
    ///   - sleep: The sleep level of the Tibby.
    ///   - friendship: The friendship level of the Tibby with its owner.
    ///   - lastUpdated: The date when the Tibby was last updated.
    ///   - isUnlocked: If this Tibby is already unlocked for the User
    init(id: UUID, ownerId: UUID?, rarity: String, details: String, personality: String, species: String, level: Int, xp: Int, happiness: Int, hunger: Int, sleep: Int, friendship: Int, lastUpdated: Date, isUnlocked: Bool) {
        self.id = id
        self.ownerId = ownerId
        self.rarity = rarity
        self.details = details
        self.personality = personality
        self.species = species
        self.level = level
        self.xp = xp
        self.happiness = happiness
        self.hunger = hunger
        self.sleep = sleep
        self.friendship = friendship
        self.lastUpdated = lastUpdated
        self.isUnlocked = isUnlocked
    }
}


enum SelectionStatus {
    case locked
    case unselected
    case selected 
    
}
