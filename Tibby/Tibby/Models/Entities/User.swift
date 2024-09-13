//
//  User.swift
//  Tibby
//
//  Created by Sofia Sartori on 27/06/24.
//

import Foundation
import SwiftData

/// A model representing a user in the application.
@Model
final class User {
    
    /// The unique identifier for the user.
    var id: UUID
    
    /// The username of the user.
    var username: String
    
    /// The email address of the user.
    var email: String?
    
    /// The hashed password of the user.
    var passwordHash: String?
    
    /// The coins and gems that the user will gain in game
    var coins: Int
    var gems: Int
    
    /// A intentory dictionary with a the Id of a Food and its Quantity
    var foodInventory: [UUID : Int] = [:]
    
    /// The identifier for the Tibby the User is currently using
    var currentTibbyID: UUID?
    
    /// A list cointaining the ids of the user's favorite tibbies (max: 3)
    var favoriteTibbies: [UUID] = []
    
    var level: Int
    
    var xp: Int
    
    init(id: UUID, username: String, email: String? = nil, passwordHash: String? = nil, currentTibbyID: UUID? = nil, level: Int, xp: Int) {
        self.id = id
        self.username = username
        self.email = email
        self.passwordHash = passwordHash
        self.coins = 0
        self.gems = 0
        self.currentTibbyID = currentTibbyID
        self.level = level
        self.xp = xp
    }
}

