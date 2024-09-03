//
//  MissionManager.swift
//  Tibby
//
//  Created by Felipe Elsner Silva on 03/09/24.
//

import Foundation

/// A struct responsible for managing the creation of missions within the Tibby app.
struct MissionManager {
    
    /// Creates a new mission based on the provided date type and mission type.
    ///
    /// - Parameters:
    ///   - dateType: The frequency or timing for the mission (e.g., daily or weekly).
    ///   - missionType: The type of mission to be created (e.g., workout, feed, sleep, steps).
    /// - Returns: A mission conforming to the `MissionProtocol`, either a `MissionDay` or `MissionWeek` based on the `dateType`.
    ///
    /// This method generates a mission by determining its difficulty level and associated rewards.
    /// For daily missions, the difficulty is randomly chosen between 1 and 2, while for weekly missions,
    /// it is randomly chosen between 5 and 6. The reward type is also randomly selected and applied to the mission.
    func createMission(dateType: DateType, missionType: MissionType) -> MissionProtocol {
        if dateType == .day {
            let difficulty = Int.random(in: 1...2)
            let rewardRaw = Int.random(in: 1...2)
            let rewardType = RewardType(rawValue: rewardRaw)!
            return MissionDay(
                description: missionType.missionDescription(value: missionType.missionValue(difficulty: difficulty), frequency: dateType),
                valueTotal: missionType.missionValue(difficulty: difficulty),
                reward: Reward(rewardValue: rewardType.rewardQuantity(difficulty: difficulty), rewardType: rewardType),
                xp: Reward(rewardValue: RewardType.xp.rewardQuantity(difficulty: difficulty), rewardType: RewardType.xp),
                missionType: missionType)
        } else {
            let difficulty = Int.random(in: 5...6)
            let rewardRaw = Int.random(in: 1...2)
            let rewardType = RewardType(rawValue: rewardRaw)!
            return MissionWeek(
                description: missionType.missionDescription(value: missionType.missionValue(difficulty: difficulty), frequency: dateType),
                valueTotal: missionType.missionValue(difficulty: difficulty),
                reward: Reward(rewardValue: rewardType.rewardQuantity(difficulty: difficulty), rewardType: rewardType),
                xp: Reward(rewardValue: RewardType.xp.rewardQuantity(difficulty: difficulty), rewardType: RewardType.xp),
                missionType: missionType)
        }
    }
    
}
