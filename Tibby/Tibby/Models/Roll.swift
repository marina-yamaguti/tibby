//
//  Roll.swift
//  Tibby
//
//  Created by Sofia Sartori on 06/08/24.
//

import Foundation

protocol RollProtocol {
    func roll(collection: Collection?, service: ServiceProtocol) -> Tibby
}

class Roll: RollProtocol {
    func roll(collection: Collection?, service: ServiceProtocol) -> Tibby {
        
        let allTibbies = service.getAllTibbies()
        let filteredTibbies: [Tibby]
        
        if let collection = collection {
            filteredTibbies = allTibbies.filter { $0.collection == collection.rawValue}
        } else {
            filteredTibbies = allTibbies
        }
        
        // Define probability distribution for each rarity
        let probabilities: [Rarity: Double] = [.common: 0.7, .rare: 0.25, .epic: 0.05]
        
        // Generate a random Tibby based on the probabilities
        func getRandomTibby() -> Tibby {
            let randomValue = Double.random(in: 0...1)
            var cumulativeProbability: Double = 0.0
            
            for (rarity, probability) in probabilities {
                cumulativeProbability += probability
                if randomValue <= cumulativeProbability {
                    let tibbiesOfRarity = filteredTibbies.filter { $0.rarity == rarity.rawValue}
                    if let randomTibby = tibbiesOfRarity.randomElement() {
                        return randomTibby
                    }
                }
            }
            // Fallback, in case no Tibby was selected (shouldn't happen if probabilities are correct)
            return filteredTibbies.randomElement() ?? allTibbies.randomElement()!
        }
        
        return getRandomTibby()
    }
}
