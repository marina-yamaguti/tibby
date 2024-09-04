//
//  Reward.swift
//  Tibby
//
//  Created by Felipe Elsner Silva on 08/07/24.
//

import Foundation

/// Represents the different types of rewards that can be earned in the Tibby app.
///
/// - xp: Experience points that help level up the user's progress.
/// - coin: In-game currency used for purchasing items or upgrades.
/// - gem: A premium currency used for special purchases or unlocking content.
enum RewardType: Int {
    case xp = 0
    case coin = 1
    case gem = 2
    
    /// Determines the quantity of the reward based on the difficulty level.
    ///
    /// - Parameter difficulty: The difficulty level of the mission, which influences the amount of the reward.
    /// - Returns: The quantity of the reward corresponding to the difficulty level.
    ///
    /// The quantity of the reward varies depending on the type of reward and the difficulty level.
    /// For example, a higher difficulty yields a greater reward quantity. This function handles
    /// the logic for all reward types (`xp`, `coin`, and `gem`) across different difficulty levels.
    func rewardQuantity(difficulty: Int) -> Int {
        switch self {
        case .xp:
            switch difficulty {
            case 1:
                return 5
            case 2:
                return 15
            case 5:
                return 20
            case 6:
                return 35
            default:
                return 0
            }
        case .coin:
            switch difficulty {
            case 1:
                return 5
            case 2:
                return 10
            case 5:
                return 20
            case 6:
                return 30
            default:
                return 0
            }
        case .gem:
            switch difficulty {
            case 1:
                return 2
            case 2:
                return 5
            case 5:
                return 10
            case 6:
                return 15
            default:
                return 0
            }
        }
    }
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
