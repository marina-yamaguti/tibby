//
//  Activity.swift
//  Tibby
//
//  Created by Sofia Sartori on 27/06/24.
//

import Foundation
import SwiftData

/// A model representing an activity in the application.
@Model
final class Activity {
    
    /// The unique identifier for the activity.
    var id: UUID
    
    /// The name of the activity.
    var name: String
    
    /// The effect of the activity. Ex: "[sleep: +2, hunger: -2]"
    var effect: String
    
    /// Initializes a new activity with the specified attributes.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the activity.
    ///   - name: The name of the activity.
    ///   - effect: The effect of the activity.
    init(id: UUID, name: String, effect: String) {
        self.id = id
        self.name = name
        self.effect = effect
    }
}

