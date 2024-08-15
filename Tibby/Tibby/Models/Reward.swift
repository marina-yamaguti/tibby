//
//  Reward.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 08/07/24.
//

import Foundation

//MARK: Types of Reward that the player can get
enum RewardType {
    case xp
    case coin
    case gem
}

/// A protocol for the rewards, the functions increase the reward for one of the types and operates it
protocol RewardProtocol {
    func reward(quantity: Int, rewardType: RewardType, user: User?, tibby: Tibby?)
    func levelUp(_ tibby: Tibby)
}


class Reward: RewardProtocol {
    //Select the reward type and increases it
    func reward(quantity: Int, rewardType: RewardType, user: User? = nil, tibby: Tibby? = nil) {
        //Select the reward type
        switch rewardType {
        case .xp:
            //increase the tibby's xp and level up the tibby
            if let tibby = tibby {
                tibby.xp += quantity
                levelUp(tibby)
            }
        case .coin:
            //increase the user's coins
            if let user = user {
                user.coins += quantity
            }
        case .gem:
            //increase the user's gems
            if let user = user {
                user.gems += quantity
            }
        }
    }
    
    //level up the player's tibby
    internal func levelUp(_ tibby: Tibby) {
        //if the tibby's xp conforms with the following conditions, level it up
        if Constants.singleton.maxLevel == -1 || tibby.level < Constants.singleton.maxLevel {
            let xpToEvolve = (tibby.level * Constants.singleton.xpPerLevel)
            if tibby.xp >= xpToEvolve {
                let auxXp = tibby.xp - xpToEvolve
                tibby.level += 1
                tibby.xp = auxXp
            }
        }
    }
}
