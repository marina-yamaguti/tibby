//
//  Roll.swift
//  Tibby
//
//  Created by Sofia Sartori on 06/08/24.
//

//
//  Roll.swift
//  Tibby
//
//  Created by Sofia Sartori on 06/08/24.
//

import Foundation

/// The `RollProtocol` defines the contract for rolling a Tibby from a collection.
protocol RollProtocol {
    /// Rolls a Tibby from the given collection using the specified service.
    ///
    /// - Parameters:
    ///   - collection: An optional `Collection` to filter the Tibbies by. If `nil`, all Tibbies are considered.
    ///   - service: A service conforming to `ServiceProtocol` to retrieve Tibbies from.
    /// - Returns: A `Tibby` selected based on the rarity probability distribution.
    func roll(collection: Collection?, service: ServiceProtocol) -> Tibby
}

/// The `Roll` class implements the `RollProtocol` and provides functionality to roll a Tibby based on rarity probabilities.
class Roll: RollProtocol {
    
    /// Rolls a Tibby from the given collection using the specified service.
    ///
    /// - Parameters:
    ///   - collection: An optional `Collection` to filter the Tibbies by. If `nil`, all Tibbies are considered.
    ///   - service: A service conforming to `ServiceProtocol` to retrieve Tibbies from.
    /// - Returns: A `Tibby` selected based on the rarity probability distribution.
    func roll(collection: Collection?, service: ServiceProtocol) -> Tibby {
        
        let allTibbies = service.getAllTibbies()
        let filteredTibbies: [Tibby]
        
        if let collection = collection {
            filteredTibbies = allTibbies.filter { $0.collection == collection.rawValue }
        } else {
            filteredTibbies = allTibbies
        }
        
        // Define probability distribution for each rarity
        let probabilities: [Rarity: Double] = [
            .common: 0.7,
            .rare: 0.25,
            .epic: 0.05
        ]
        
        func getRandomTibby() -> Tibby {
            let randomValue = Double.random(in: 0...1)
            var cumulativeProbability: Double = 0.0
            
            for (rarity, probability) in probabilities {
                cumulativeProbability += probability
                if randomValue <= cumulativeProbability {
                    // Filter Tibbies by the current rarity
                    let tibbiesOfRarity = filteredTibbies.filter { $0.rarity == rarity.rawValue }
                    if let randomTibby = tibbiesOfRarity.randomElement() {
                        return randomTibby
                    }
                }
            }
            return filteredTibbies.randomElement() ?? allTibbies.randomElement()!
        }

        return getRandomTibby()
    }
}
