//
//  Tibby.swift
//  Tibby
//
//  Created by Sofia Sartori on 26/06/24.
//

import Foundation
import SwiftData
import SpriteKit

// MARK: - TibbySpecie Enum

/// An enum representing the different species of Tibbies.
///
/// Each species has associated animations for different states such as base, sleep, happy, sad, and eating.
enum TibbySpecie: String {
    case shark
    case dolphin
    case yellowShark
    
    /// Returns the base animation frames for the species.
    func baseAnimation() -> [String] {
        switch self {
        case .shark:
            return ["shark1", "shark2"]
        case .yellowShark:
            return ["yellowShark1", "yellowShark2"]
        case .dolphin:
            return ["dolphin1", "dolphin2"]
        }
    }
    
    /// Returns the sleep animation frames for the species.
    func sleepAnimation() -> [String] {
        switch self {
        case .shark:
            return ["sharkSleep1", "sharkSleep2", "sharkSleep3", "sharkSleep4"]
        case .yellowShark:
            return ["yellowSharkSleep1", "yellowSharkSleep2", "yellowSharkSleep3", "yellowSharkSleep4"]
        case .dolphin:
            return ["dolphinSleep1", "dolphinSleep2", "dolphinSleep3", "dolphinSleep4"]
        }
    }
    
    /// Returns the happy animation frames for the species.
    func happyAnimation() -> [String] {
        switch self {
        case .shark:
            return ["sharkHappy1", "sharkHappy2"]
        case .yellowShark:
            return ["yellowSharkHappy1", "yellowSharkHappy2"]
        case .dolphin:
            return ["dolphinHappy1", "dolphinHappy2"]
        }
    }
    
    /// Returns the sad animation frames for the species.
    func sadAnimation() -> [String] {
        switch self {
        case .shark:
            return ["sharkSad1", "sharkSad2"]
        case .yellowShark:
            return ["yellowSharkSad1", "yellowSharkSad2"]
        case .dolphin:
            return ["dolphinSad1", "dolphinSad2"]
        }
    }
    
    /// Returns the eat animation frames for the species.
    func eatAnimation() -> [String] {
        switch self {
        case .shark:
            return ["sharkEat1", "sharkEat2"]
        case .yellowShark:
            return ["yellowSharkEat1", "yellowSharkEat2"]
        case .dolphin:
            return ["dolphinEat1", "dolphinEat2"]
        }
    }
}

// MARK: - NodeType Enum

/// An enum representing the types of nodes in the SpriteKit view.
enum NodeType {
    case tibby
    case accessory
}

// MARK: - TibbyStatus Enum

/// An enum representing the various states of a Tibby.
enum TibbyStatus {
    case hungry
    case sleep
    case happy
    
    /// The time in seconds required to decrease 1 point in the Tibby's necessity.
    ///
    /// - Returns: A `Double` representing the time in seconds.
    func timeDecrease() -> Double {
        switch self {
        case .hungry:
            return 172
        case .sleep:
            return 432
        case .happy:
            return 172
        }
    }
}

// MARK: - TibbyProtocol Protocol

/// A protocol defining the interface for interacting with Tibby views in SpriteKit within a SwiftUI view.
protocol TibbyProtocol {
    
    // MARK: - Tibby and Accessory Node Instances
    
    /// The Tibby node in the SpriteKit view.
    var tibby: SKSpriteNode { get set }
    
    /// The accessory node in the SpriteKit view.
    var accessory: SKSpriteNode { get set }
    
    /// The Tibby object associated with the view.
    var tibbyObject: Tibby? { get set }
    
    /// The species of the Tibby.
    var tibbySpecie: TibbySpecie? { get set }
    
    /// Sets the Tibby object, constants, and service for the view.
    ///
    /// - Parameters:
    ///   - tibbyObject: The `Tibby` object to be set.
    ///   - constants: The `Constants` object used in the view.
    ///   - service: The `Service` object used in the view.
    func setTibby(tibbyObject: Tibby, constants: Constants, service: Service)
    
    /// Sets the Tibby species for the view.
    ///
    /// - Parameter tibbySpecie: The `TibbySpecie` to be set.
    func setTibbySpecie(tibbySpecie: TibbySpecie)
    
    /// Adds an accessory to the SpriteKit view and updates the SwiftData model.
    ///
    /// - Parameters:
    ///   - accessory: The `Accessory` to be added.
    ///   - service: The `Service` used to update the model.
    ///   - tibbyID: The `UUID` of the Tibby the accessory is associated with.
    func addAccessory(_ accessory: Accessory, _ service: Service, tibbyID: UUID?)
    
    /// Removes the accessory from the SpriteKit view and updates the SwiftData model.
    ///
    /// - Parameter service: The `Service` used to update the model.
    func removeAccessory(_ service: Service)
    
    /// Animates the Tibby with a given set of images.
    ///
    /// - Parameters:
    ///   - textureList: An array of strings representing the texture frames for the animation.
    ///   - nodeID: The type of node being animated (Tibby or accessory).
    ///   - timeFrame: The time interval between each frame of the animation.
    func animateTibby(_ textureList: [String], nodeID: NodeType, timeFrame: TimeInterval)
}

// MARK: - Tibby Model

/// A model representing a Tibby, a virtual pet with various attributes and states.
@Model
final class Tibby {
    /// The unique identifier for the Tibby.
    var id: UUID
    
    /// The unique identifier of the owner of the Tibby.
    var ownerId: UUID?
    
    /// The name of the Tibby.
    var name: String
    
    /// The rarity of the Tibby.
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
    
    /// A Boolean value indicating whether the Tibby is unlocked for the main user.
    var isUnlocked: Bool
    
    /// The collection this Tibby is a part of.
    var collection: String
    
    init(id: UUID, ownerId: UUID?, name: String, rarity: String, details: String, personality: String, species: String, level: Int, xp: Int, happiness: Int, hunger: Int, sleep: Int, friendship: Int, lastUpdated: Date, isUnlocked: Bool, collection: String) {
        self.id = id
        self.ownerId = ownerId
        self.name = name
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
        self.collection = collection
    }
}

// MARK: - SelectionStatus Enum

/// An enum representing the selection status of a Tibby.
enum SelectionStatus {
    case locked
    case unselected
    case selected
}
