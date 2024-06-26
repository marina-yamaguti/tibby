//
//  Tibby.swift
//  Tibby
//
//  Created by Sofia Sartori on 26/06/24.
//

import Foundation
import SwiftData

/// A model representing a Tibby, a virtual pet with various attributes and states.
@Model
final class Tibby {
    
    /// The unique identifier for the Tibby.
    var id: UUID
    
    /// The unique identifier of the owner of the Tibby.
    var ownerId: UUID
    
    /// The name of the Tibby.
    var name: String
    
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
    
    /// Initializes a new Tibby with the specified attributes.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the Tibby.
    ///   - ownerId: The unique identifier of the owner of the Tibby.
    ///   - name: The name of the Tibby.
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
    init(id: UUID, ownerId: UUID, name: String, details: String, personality: String, species: String, level: Int, xp: Int, happiness: Int, hunger: Int, sleep: Int, friendship: Int, lastUpdated: Date) {
        self.id = id
        self.ownerId = ownerId
        self.name = name
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
    }
}
