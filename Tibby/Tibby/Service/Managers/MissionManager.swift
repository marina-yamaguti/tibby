//
//  MissionManager.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 03/09/24.
//

import Foundation

struct MissionManager {
    
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
        }
        else {
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
