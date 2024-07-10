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
    
    /// A intentory dictionary with a the Id of a Food and its Quantity
    var foodInventory: [UUID : Int] = [:]
    
    /// Initializes a new user with the specified attributes.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the user.
    ///   - username: The username of the user.
    ///   - email: The email address of the user. Default is `nil`.
    ///   - passwordHash: The hashed password of the user. Default is `nil`.
    init(id: UUID, username: String, email: String? = nil, passwordHash: String? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.passwordHash = passwordHash
    }
}

