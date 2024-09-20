//
//  MissionsView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/09/24.
//

import SwiftUI

struct MissionsView: View {
    @State var streak = GameStreak()
    @EnvironmentObject var constants: Constants
    
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
                            Text("\(constants.dailyMission.timeRemaning.timeValue) \(constants.dailyMission.timeRemaning.timeMesure.rawValue)\(constants.dailyMission.timeRemaning.timeValue > 1 ? "s" : "") remaining")
                                .font(.typography(.label))
                                .foregroundStyle(.tibbyBaseRed)
                        }
                        Spacer()
                        
                        NavigationLink(destination: StreakView(streak: GameStreak())) {
                            StreakUpComponent(streakCount: streak.currentStreak)
                        }
                    }
                    .padding(.bottom, 16)
                    
                    // Display the missions in the daily mission collection
                    MissionCardComponent(missions: constants.dailyMission.getMissions())
                }
                .padding(.bottom, 16)
                
                // Weekly Mission Section
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Weekly Mission")
                            .font(.typography(.body))
                            .foregroundStyle(.tibbyBaseBlack)
                        Text("\(constants.weeklyMission.timeRemaning.timeValue) \(constants.weeklyMission.timeRemaning.timeMesure.rawValue)\(constants.weeklyMission.timeRemaning.timeValue > 1 ? "s" : "") remaining")
                            .font(.typography(.label))
                            .foregroundStyle(.tibbyBaseRed)
                    }
                    .padding(.bottom, 16)
                    
                    // Display the missions in the weekly mission collection
                    MissionCardComponent(missions: constants.weeklyMission.getMissions())
                }
                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 33)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
    }
}


//#Preview {
//    let missionManager = MissionManager()
//    
//    // Generate some example daily and weekly missions using the MissionManager
//    let dailyMissions = DayMissionsCollection(
//        title: "Daily Missions",
//        missions: MissionType.allCases.map { missionManager.createMission(dateType: .day, missionType: $0) }
//    )
//    
//    let weeklyMissions = WeekMissionsCollection(
//        title: "Weekly Missions",
//        missions: MissionType.allCases.map { missionManager.createMission(dateType: .week, missionType: $0) }
//    )
//    
//    return MissionsView(dailyMission: dailyMissions, weeklyMission: weeklyMissions)
//}
