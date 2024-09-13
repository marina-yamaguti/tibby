//
//  MissionProgressComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 11/09/24.
//

import SwiftUI

struct MissionProgressComponent: View {
    @State var mission: MissionProtocol
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 8) {
                Image(mission.missionType.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25, alignment: .center)
                    .padding(8)
                    .background {
                        Circle()
                            .fill(mission.progress == .done ? .tibbyBaseGrey : .tibbyBaseDarkBlue)
                    }
                
                VStack(spacing: 8) {
                    Text(mission.description)
                        .font(.typography(.label))
                        .foregroundStyle(mission.progress == .done ? .tibbyBaseGrey : .tibbyBaseDarkBlue)
                        .strikethrough(mission.progress == .done)
                    
                    ProgressView(value: Double(mission.valueDone), total: Double(mission.valueTotal))
                        .progressViewStyle(MissionsProgressBar(totalValue: mission.valueTotal))
                }
                .opacity(mission.progress == .done ? 0.1 : 1)
                
                
                
                OfferedRewardComponent(isCompleted: mission.progress == .done, reward: mission.reward)
                    .padding(.trailing, mission.progress == .claim ? 40 : 0)
            }
            .background {
                if mission.progress == .claim {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.tibbyBaseSaturatedGreen.opacity(0.5))
                }
            }
            .frame(height: 40)
            
            if mission.progress == .claim {
                Text("Click to Claim")
                    .font(.typography(.label))
                    .foregroundStyle(.tibbyBaseDarkBlue)
            }
        }
        .opacity(mission.progress == .done ? 0.6 : 1)
    }
}

#Preview {
    MissionProgressComponent(mission: MissionDay(id: UUID(), description: "60 minute workout", valueTotal: 60, reward: Reward(rewardValue: 10, rewardType: .gem), xp: Reward(rewardValue: 10, rewardType: .coin), missionType: .workout))
}
