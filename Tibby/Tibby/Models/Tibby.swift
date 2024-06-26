//
//  Tibby.swift
//  Tibby
//
//  Created by Sofia Sartori on 26/06/24.
//

import Foundation
import SwiftData

@Model
final class Tibby {
    var id: UUID
    var ownerId: UUID
    var name: String
    var details: String
    var personality: String
    var species: String
    var level: Int
    var xp: Int
    var happiness: Int
    var hunger: Int
    var sleep: Int
    var friendship: Int
    var lastUpdated: Date
    
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
