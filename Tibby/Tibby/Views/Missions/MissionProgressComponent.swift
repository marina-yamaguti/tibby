//
//  MissionProgressComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 11/09/24.
//

import SwiftUI

struct MissionProgressComponent: View {
    @Binding var mission: MissionProtocol
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
                    if mission.frequencyTime == .week && mission.missionType == .workout {
                        ProgressView(value: Double(Int(mission.valueDone/60)), total: Double(Int(mission.valueTotal/60)))
                            .progressViewStyle(MissionsProgressBar(totalValue: Int(mission.valueTotal/60)))
                    }
                    else {
                        let totalValue = Double(mission.valueTotal)
                        let clampedValue = min(max(Double(mission.valueDone), 0), totalValue > 0 ? totalValue : 1)

                        ProgressView(value: clampedValue, total: totalValue > 0 ? totalValue : 1)  
                            .progressViewStyle(MissionsProgressBar(totalValue: mission.valueTotal))
                    }
                }
                .opacity(mission.progress == .done || mission.progress == .claim ? 0.1 : 1)
                
                
                
                OfferedRewardComponent(isCompleted: mission.progress == .done, isClaim: mission.progress == .claim, reward: mission.reward)
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

