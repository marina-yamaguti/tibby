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
enum TibbySpecie: String, CaseIterable {
    case shark = "shark"
    case dolphin = "dolphin"
    case yellowShark = "yellowShark"
    case axolotl = "axolotl"
    case tuxedoCat = "tuxedoCat"
    case bunny = "bunny"
    case corgi = "corgi"
    case dog = "dog"
    case bear = "bear"
    
    
    /// Returns the base animation frames for the species.
    func baseAnimation() -> [String] {
        switch self {
        case .shark:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/sharkBase1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/sharkBase2.png"
            ]
        case .yellowShark:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbySharkYellow1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbySharkYellow2.png"
            ]
        case .dolphin:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinBase1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinBase2.png"
            ]
        case .axolotl:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyAxolotl1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/Axolotl2.png"
            ]
        case .tuxedoCat:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatBase1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatBase2.png"
            ]
        case .bunny:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/Bunny1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/Bunny2.png"
            ]
        case .corgi:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/Corgi1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/Corgi2.png"
            ]
        case .dog:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogBase1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogBase2.png"
            ]
        case .bear:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/Bear1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/Bear2.png"
            ]
        }
    }
    
    /// Returns the sleep animation frames for the species.
    func sleepAnimation() -> [String] {
        switch self {
        case .shark:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/sharkSleep1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/sharkSleep2.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/sharkSleep3.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/sharkSleep4.png"
            ]
        case .yellowShark:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/shark2Sleep1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/shark2Sleep2.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/shark2Sleep3.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/shark2Sleep4.png"
            ]
        case .dolphin:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinSleep1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinSleep2.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinSleep3.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinSleep4.png"
            ]
        case .axolotl:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyAxolotlSleep1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyAxolotlSleep2.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyAxolotlSleep3.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyAxolotlSleep4.png"
            ]
        case .tuxedoCat:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatSleep1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatSleep2.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatSleep3.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatSleep4.png"
            ]
        case .bunny:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BunnySleep1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BunnySleep2.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BunnySleep3.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BunnySleep4.png"
            ]
        case .corgi:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CorgiSleep1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CorgiSleep2.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CorgiSleep3.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CorgiSleep4.png"
            ]
        case .dog:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogSleep1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogSleep2.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogSleep3.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogSleep4.png"
            ]
        case .bear:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BearSleep1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BearSleep2.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BearSleep3.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BearSleep4.png"
            ]
        }
    }
    
    /// Returns the happy animation frames for the species.
    func happyAnimation() -> [String] {
        switch self {
        case .shark:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/shark1Happy1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/shark1Happy2.png"
            ]
        case .yellowShark:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/shark2Happy1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/shark2Happy2.png"
            ]
        case .dolphin:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinHappy1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinHappy2.png"
            ]
        case .axolotl:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyAxolotHappyl1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyAxolotHappyl2.png"
            ]
        case .tuxedoCat:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatHappy1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatHappy2.png"
            ]
        case .bunny:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BunnyHappy1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BunnyHappy2.png"
            ]
        case .corgi:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CorgiHappy1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CorgiHappy2.png"
            ]
        case .dog:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogHappy1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogHappy2.png"
            ]
        case .bear:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BearHappy1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BearHappy2.png"
            ]
        }
    }
    
    /// Returns the sad animation frames for the species.
    func sadAnimation() -> [String] {
        switch self {
        case .shark:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/sharkSad1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/sharkSad2.png"
            ]
        case .yellowShark:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/shark2Sad1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/shark2Sad4.png"
            ]
        case .dolphin:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinSad1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinSad2.png"
            ]
        case .axolotl:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyAxolotlSad1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyAxolotlSad2.png"
            ]
        case .tuxedoCat:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatSad1.png",
                
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatSad2.png"
            ]
        case .bunny:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BunnySad1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BunnySad2.png"
            ]
        case .corgi:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CorgiSad1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CorgiSad2.png"
            ]
        case .dog:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogSad1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogSad2.png"
            ]
        case .bear:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BearSad1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BearSad2.png"
            ]
            
        }
    }
    
    /// Returns the eat animation frames for the species.
    func eatAnimation() -> [String] {
        switch self {
        case .shark:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/sharkEating1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/sharkEating2.png"
            ]
        case .yellowShark:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/shark2Sad2.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbySharkYellow2.png"
            ]
        case .dolphin:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphin1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinEating2.png"
            ]
        case .axolotl:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/AxolotlEating1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/Axolotl2.png"
            ]
        case .tuxedoCat:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatEat1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CatBase2.png"
            ]
        case .bunny:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BunnyEat1.png",
                    "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/Bunny2.png"
            ]
        case .corgi:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/CorgiEat1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/Corgi2.png"
            ]
        case .dog:
            return ["https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogEat1.png",
                    "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/dogEat2.png"
            ]
        case .bear:
            return [
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/BearEat1.png",
                "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/Bear2.png"
            ]
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
    var tibby: SKSpriteNode {
        get set
    }
    
    /// The accessory node in the SpriteKit view.
    var accessory: SKSpriteNode {
        get set
    }
    
    /// The Tibby object associated with the view.
    var tibbyObject: Tibby? {
        get set
    }
    
    /// The species of the Tibby.
    var tibbySpecie: TibbySpecie? {
        get set
    }
    
    /// Sets the Tibby object, constants, and service for the view.
    ///
    /// - Parameters:
    ///   - tibbyObject: The `Tibby` object to be set.
    ///   - constants: The `Constants` object used in the view.
    ///   - service: The `Service` object used in the view.
    func setTibby(
        tibbyObject: Tibby,
        constants: Constants,
        service: Service
    )
    
    /// Sets the Tibby species for the view.
    ///
    /// - Parameter tibbySpecie: The `TibbySpecie` to be set.
    func setTibbySpecie(
        tibbySpecie: TibbySpecie
    )
    
    ///Functions to add and remove accessory from the SpriteKit View and SwiftData only populating deleting the accessory reference
    func addAccessory(
        _ accessory: Accessory,
        species: String,
        completion: ()->Void,
        remove: ()-> Void
    )
    func removeAccessory(
        completion: ()->Void
    )
    ///Pass the set of images for the animation and what is animating
    func animateTibby(
        _ textureList: [String],
        nodeID: NodeType,
        timeFrame: TimeInterval
    )
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
    
    /// The unique identifier of the current Accessory the Tibby is using.
    var currentAccessoryId: UUID? = nil
    
    init(
        id: UUID,
        ownerId: UUID?,
        name: String,
        rarity: String,
        details: String,
        personality: String,
        species: String,
        happiness: Int,
        hunger: Int,
        sleep: Int,
        friendship: Int,
        lastUpdated: Date,
        isUnlocked: Bool,
        collection: String
    ) {
        self.id = id
        self.ownerId = ownerId
        self.name = name
        self.rarity = rarity
        self.details = details
        self.personality = personality
        self.species = species
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
