//
//  Item.swift
//  Tibby
//
//  Created by Mateus Moura Godinho on 26/06/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
