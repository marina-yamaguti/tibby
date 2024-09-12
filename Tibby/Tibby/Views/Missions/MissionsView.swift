//
//  MissionsView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/09/24.
//

import SwiftUI

struct MissionsView: View {
    @State var streak = GameStreak()
    @State var dailyMission: DayMissionsCollection
    @State var weeklyMission: WeekMissionsCollection
    let missionManager = MissionManager() // Add MissionManager instance


    
    var body: some View {
        VStack(spacing: 0) {
            PageHeader(title: "Missions", symbol: TibbySymbols.listBlack.rawValue)
            
            VStack {
                // Daily Mission Section
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Daily Mission")
                                .font(.typography(.body))
                                .foregroundStyle(.tibbyBaseBlack)
                            Text("\(dailyMission.timeRemaning.timeValue) \(dailyMission.timeRemaning.timeMesure.rawValue)\(dailyMission.timeRemaning.timeValue > 1 ? "s" : "") remaining")
                                .font(.typography(.label))
                                .foregroundStyle(.tibbyBaseRed)
                        }
                        Spacer()
                        
                        NavigationLink(destination: MissionsStreakView()) {
                            StreakUpComponent(streakCount: streak.currentStreak)
                        }
                    }
                    .padding(.bottom, 16)
                    
                    // Display the missions in the daily mission collection
                    MissionCardComponent(missions: dailyMission.getMissions())
                }
                .padding(.bottom, 16)
                
                // Weekly Mission Section
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Weekly Mission")
                            .font(.typography(.body))
                            .foregroundStyle(.tibbyBaseBlack)
                        Text("\(weeklyMission.timeRemaning.timeValue) \(weeklyMission.timeRemaning.timeMesure.rawValue)\(weeklyMission.timeRemaning.timeValue > 1 ? "s" : "") remaining")
                            .font(.typography(.label))
                            .foregroundStyle(.tibbyBaseRed)
                    }
                    .padding(.bottom, 16)
                    
                    // Display the missions in the weekly mission collection
                    MissionCardComponent(missions: weeklyMission.getMissions())
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 33)
        }
        .ignoresSafeArea(.all)
    }
    func generateMissions() {
        dailyMission.missions = MissionType.allCases.map {
            missionManager.createMission(dateType: .day, missionType: $0)
        }

        weeklyMission.missions = MissionType.allCases.map {
            missionManager.createMission(dateType: .week, missionType: $0)
        }
    }
}


#Preview {
    let missionManager = MissionManager()
    
    // Generate some example daily and weekly missions using the MissionManager
    let dailyMissions = DayMissionsCollection(
        title: "Daily Missions",
        missions: MissionType.allCases.map { missionManager.createMission(dateType: .day, missionType: $0) }
    )
    
    let weeklyMissions = WeekMissionsCollection(
        title: "Weekly Missions",
        missions: MissionType.allCases.map { missionManager.createMission(dateType: .week, missionType: $0) }
    )
    
    return MissionsView(dailyMission: dailyMissions, weeklyMission: weeklyMissions)
}
