//
//  Item.swift
//  tibby
//
//  Created by Sofia Sartori on 26/06/24.
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
