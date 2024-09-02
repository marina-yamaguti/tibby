//
//  Accessory.swift
//  Tibby
//
//  Created by Sofia Sartori on 27/06/24.
//

import Foundation
import SwiftData

/// A model representing an accessory in the application.
@Model
final class Accessory {
    
    /// The unique identifier for the accessory.
    var id: UUID
    
    /// The identifier for the associated Tibby, if any.
    var tibbyId: UUID?
    
    /// The name of the accessory.
    var name: String
    
    /// The image associated with the accessory.
    var image: String
    
    /// The price for this Item
    var price: Int
    
    /// The category this item belongs to
    var category: String
    
    /// Initializes a new accessory with the specified attributes.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the accessory.
    ///   - tibbyId: The identifier for the associated Tibby. Default is `nil`.
    ///   - name: The name of the accessory.
    ///   - image: The image associated with the accessory.
    ///   - price: The price for this Item
    ///   - category: The
    init(id: UUID, tibbyId: UUID? = nil, name: String, image: String, price: Int, category: String) {
        self.id = id
        self.tibbyId = tibbyId
        self.name = name
        self.image = image
        self.price = price
        self.category = category
    }
}

