//
//  Interaction.swift
//  Tibby
//
//  Created by Sofia Sartori on 27/06/24.
//

import Foundation
import SwiftData

/// A model representing an interaction between a Tibby and an activity in the application.
@Model
final class Interaction {
    
    /// The unique identifier for the interaction.
    var id: UUID
    
    /// The identifier for the Tibby involved in the interaction.
    var tibbyId: UUID
    
    /// The identifier for the activity involved in the interaction.
    var activityId: UUID
    
    /// The timestamp of when the interaction occurred.
    var timestamp: Date
    
    /// Initializes a new interaction with the specified attributes.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the interaction.
    ///   - tibbyId: The identifier for the Tibby involved in the interaction.
    ///   - activityId: The identifier for the activity involved in the interaction.
    ///   - timestamp: The timestamp of when the interaction occurred.
    init(id: UUID, tibbyId: UUID, activityId: UUID, timestamp: Date) {
        self.id = id
        self.tibbyId = tibbyId
        self.activityId = activityId
        self.timestamp = timestamp
    }
}

