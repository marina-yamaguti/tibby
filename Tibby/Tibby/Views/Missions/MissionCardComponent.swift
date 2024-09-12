//
//  MissionCardComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 11/09/24.
//

import SwiftUI

struct MissionCardComponent: View {
    var missions: [MissionProtocol]
    var body: some View {
        VStack(spacing: 0) {
            ForEach(missions, id: \.id) { mission in
                MissionProgressComponent(mission: mission)
                    .padding(.vertical, 8)
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.tibbyBasePearlBlue)
        }
    }
    
}

#Preview {
    MissionCardComponent(missions: [MissionDay(id: UUID(), description: "Walk 10,000 steps", valueTotal: 60, reward: Reward(rewardValue: 10, rewardType: RewardType.coin), xp: Reward(rewardValue: 10, rewardType: .coin), missionType: MissionType.steps), MissionDay(id: UUID(), description: "Walk 10000,000 steps", valueTotal: 60, reward: Reward(rewardValue: 10, rewardType: RewardType.coin), xp: Reward(rewardValue: 10, rewardType: .coin), missionType: MissionType.steps), MissionDay(id: UUID(), description: "Walk 3 steps", valueTotal: 60, reward: Reward(rewardValue: 10, rewardType: RewardType.coin), xp: Reward(rewardValue: 10, rewardType: .coin), missionType: MissionType.steps), MissionDay(id: UUID(), description: "Walk 2 steps", valueTotal: 60, reward: Reward(rewardValue: 10, rewardType: RewardType.coin), xp: Reward(rewardValue: 10, rewardType: .coin), missionType: MissionType.steps)])
}
