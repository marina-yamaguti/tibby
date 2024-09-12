//
//  MissionsView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/09/24.
//

import SwiftUI

struct MissionsView: View {
    @State var dailyMission: [MissionDay]
    @State var weeklyMission: [MissionWeek]
    var body: some View {
        VStack(spacing: 0) {
            PageHeader(title: "Missions", symbol: TibbySymbols.listBlack.rawValue)
            
            VStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Daily Mission")
                                .font(.typography(.body))
                                .foregroundStyle(.tibbyBaseBlack)
                            Text("hours remaining")
                                .font(.typography(.label))
                                .foregroundStyle(.tibbyBaseRed)
                        }
                        Spacer()
                        
                        
                        NavigationLink(destination: MissionsStreakUpComponent()) {
                            StreakUpComponent(streakCount: 0)
                        }
                    }
                    .padding(.bottom, 16)
                    
                    MissionCardComponent(missions: dailyMission)
                    
                }
                .padding(.bottom, 16)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Weekly Mission")
                            .font(.typography(.body))
                            .foregroundStyle(.tibbyBaseBlack)
                        Text("hours remaining")
                            .font(.typography(.label))
                            .foregroundStyle(.tibbyBaseRed)
                        
                    }
                    .padding(.bottom, 16)
                    
                    MissionCardComponent(missions: weeklyMission)
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 33)
            
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    MissionsView(
        dailyMission:
            [MissionDay(id: UUID(), description: "description", valueTotal: 10, reward: Reward(rewardValue: 2, rewardType: .coin), xp: Reward(rewardValue: 2, rewardType: .coin), missionType: .steps),
             MissionDay(id: UUID(), description: "description 2", valueTotal: 10, reward: Reward(rewardValue: 2, rewardType: .coin), xp: Reward(rewardValue: 2, rewardType: .coin), missionType: .steps),
             MissionDay(id: UUID(), description: "description 3", valueTotal: 10, reward: Reward(rewardValue: 2, rewardType: .coin), xp: Reward(rewardValue: 2, rewardType: .coin), missionType: .steps),
             MissionDay(id: UUID(), description: "description 4", valueTotal: 10, reward: Reward(rewardValue: 2, rewardType: .coin), xp: Reward(rewardValue: 2, rewardType: .coin), missionType: .steps)],
        weeklyMission:
            [MissionWeek(id: UUID(), description: "description weekly 1", valueTotal: 10, reward: Reward(rewardValue: 2, rewardType: .coin), xp: Reward(rewardValue: 2, rewardType: .coin), missionType: .feed), MissionWeek(id: UUID(), description: "description weekly", valueTotal: 10, reward: Reward(rewardValue: 2, rewardType: .coin), xp: Reward(rewardValue: 2, rewardType: .coin), missionType: .feed), MissionWeek(id: UUID(), description: "description weekly 2", valueTotal: 10, reward: Reward(rewardValue: 2, rewardType: .coin), xp: Reward(rewardValue: 2, rewardType: .coin), missionType: .feed), MissionWeek(id: UUID(), description: "description weekly", valueTotal: 10, reward: Reward(rewardValue: 2, rewardType: .coin), xp: Reward(rewardValue: 2, rewardType: .coin), missionType: .feed)])
}
