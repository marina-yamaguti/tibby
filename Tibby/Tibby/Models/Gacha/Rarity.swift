//
//  Rarity.swift
//  Tibby
//
//  Created by Sofia Sartori on 06/08/24.
//

import Foundation

/// An enumeration representing the rarity of an item.
enum Rarity: String {
    case common = "Common"
    case rare = "Rare"
    case epic = "Epic"
    
    var capsuleImage: String {
        switch self {
        case .common:
            return "CapsuleCommon"
        case .rare:
            return "CapsuleRare"
        case .epic:
            return "CapsuleEpic"
        }
    }
}


