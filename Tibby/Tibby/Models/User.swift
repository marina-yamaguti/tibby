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
    
    /// Initializes a new user with the specified attributes.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the user.
    ///   - username: The username of the user.
    ///   - email: The email address of the user. Default is `nil`.
    ///   - passwordHash: The hashed password of the user. Default is `nil`.
    ///   - coins: The coins of the user. Always will start with `0`.
    ///   - gems: The gems of the user. Always will start with `0`.
    init(id: UUID, username: String, email: String? = nil, passwordHash: String? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.passwordHash = passwordHash
        self.coins = 0
        self.gems = 0
    }
}

