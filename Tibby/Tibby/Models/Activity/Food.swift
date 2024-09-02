//
//  Food.swift
//  Tibby
//
//  Created by Sofia Sartori on 08/07/24.
//

import Foundation
import SwiftData

/// A model representing an accessory in the application.
@Model
final class Food {
    
    /// The unique identifier for the accessory.
    var id: UUID
    
    /// The name of the accessory.
    var name: String
    
    /// The image associated with the accessory.
    var image: String
    
    /// The price of this Item
    var price: Int
    
    init(id: UUID, name: String, image: String, price: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
    }
}
