//
//  Rarity.swift
//  Tibby
//
//  Created by Sofia Sartori on 06/08/24.
//

import Foundation

/// An enumeration representing the rarity of an item.
enum Rarity: String, CaseIterable{
    case common = "Common"
    case rare = "Rare"
    case epic = "Epic"
    
    var order: Int {
        switch self {
        case .common:
            return 1
        case .rare:
            return 2
        case .epic:
            return 3
        }
    }
    
    init?(rawString: String) {
        switch rawString.lowercased() {
        case "common":
            self = .common
        case "rare":
            self = .rare
        case "epic":
            self = .epic
        default:
            return nil
        }
    }
    
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


