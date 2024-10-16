//
//  MissionCardComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 11/09/24.
//

import SwiftUI

struct MissionCardComponent: View {
    @EnvironmentObject var service: Service
    @Binding var missions: [MissionProtocol]
    @Binding var reorderMissions: Bool
    @State private var gameStreak = GameStreak() // Create a local instance of GameStreak
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach($missions, id: \.id) { $mission in
                MissionProgressComponent(mission: $mission)
                    .padding(.vertical, 8)
                    .onTapGesture {
                        mission.claimReward(user: service.getUser()!, action: {
                            reorderMissions.toggle()
                            gameStreak.incrementStreak()
                        })
                    }
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.tibbyBasePearlBlue)
        }
    }
    
    /// Increment the streak directly when a mission is completed.
    private func incrementStreak() {
        gameStreak.incrementStreak()
    }
}
