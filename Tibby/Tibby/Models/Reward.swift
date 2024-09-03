//
//  Reward.swift
//  Tibby
//
//  Created by Felipe Elsner Silva on 08/07/24.
//

import Foundation

/// An enumeration representing the different types of rewards a player can receive.
enum RewardType {
    case xp
    case coin
    case gem
}

/// A protocol defining the structure for reward management.
///
/// This protocol outlines methods for granting rewards to users or Tibbies and for leveling up Tibbies.
protocol RewardProtocol {
    /// Parameters that all Reward needs to have
    var rewardValue: Int { get }
    var rewardType: RewardType { get }
    
    /// Grants a reward of the specified type and quantity to a user or Tibby.
    ///
    /// - Parameters:
    ///   - user: An optional `User` object to receive the reward (for coins or gems).
    ///   - tibby: An optional `Tibby` object to receive the reward (for XP).
    func reward(user: User?, tibby: Tibby?)
}

/// A class that implements the `RewardProtocol`, providing functionality to manage rewards and Tibby leveling.
class Reward: RewardProtocol {
    /// Parameters of the value of the reward that the user will claim and the type of it
    var rewardValue: Int
    var rewardType: RewardType
    
    init(rewardValue: Int, rewardType: RewardType) {
        self.rewardValue = rewardValue
        self.rewardType = rewardType
    }
    
    /// Grants a reward of the specified type and quantity to a user or Tibby.
    ///
    /// Depending on the `rewardType`, this method will either increase the Tibby's XP, the user's coins, or the user's gems.
    ///
    /// - Parameters:
    ///   - user: An optional `User` object to receive the reward (for coins or gems).
    ///   - tibby: An optional `Tibby` object to receive the reward (for XP).
    func reward(user: User? = nil, tibby: Tibby? = nil) {
        switch rewardType {
        case .xp:
            // Increase the Tibby's XP and check for level up
            if let tibby = tibby {
                tibby.xp += rewardValue
                levelUp(tibby)
            }
        case .coin:
            // Increase the user's coins
            if let user = user {
                user.coins += rewardValue
            }
        case .gem:
            // Increase the user's gems
            if let user = user {
                user.gems += rewardValue
            }
        }
    }
    
    /// Levels up the specified Tibby if its XP meets the criteria.
    ///
    /// The Tibby will level up if its XP exceeds the required amount, with any excess XP carried over to the next level.
    ///
    /// - Parameter tibby: The `Tibby` to be leveled up.
    private func levelUp(_ tibby: Tibby) {
        // Check if the Tibby's XP meets the threshold for leveling up
        if Constants.singleton.maxLevel == -1 || tibby.level < Constants.singleton.maxLevel {
            let xpToEvolve = tibby.level * Constants.singleton.xpPerLevel
            if tibby.xp >= xpToEvolve {
                let auxXp = tibby.xp - xpToEvolve
                tibby.level += 1
                tibby.xp = auxXp
            }
        }
    }
}
