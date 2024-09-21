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
//    @EnvironmentObject var service: Service
    
    var body: some View {
        VStack(spacing: 0) {
            PageHeader(title: "Missions", symbol: TibbySymbols.listBlack.rawValue)
            ScrollView {
                VStack {
                    // Daily Mission Section
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Daily Mission")
                                    .font(.typography(.body))
                                    .foregroundStyle(.tibbyBaseBlack)
//                                Text("\(constants.dailyMission.timeRemaning.timeValue) \(constants.dailyMission.timeRemaning.timeMesure.rawValue)\(constants.dailyMission.timeRemaning.timeValue > 1 ? "s" : "") remaining")
//                                    .font(.typography(.label))
//                                    .foregroundStyle(.tibbyBaseRed)
                            }
                            Spacer()
                            
                            NavigationLink(destination: StreakView()) {
                                StreakUpComponent()
                            }
                        }
                        .padding(.bottom, 16)
                        
                        // Display the missions in the daily mission collection
                        MissionCardComponent(missions: $constants.dailyMission.missions)
                    }
                    .padding(.bottom, 16)
                    
                    // Weekly Mission Section
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Weekly Mission")
                                .font(.typography(.body))
                                .foregroundStyle(.tibbyBaseBlack)
//                            Text("\(constants.weeklyMission.timeRemaning.timeValue) \(constants.weeklyMission.timeRemaning.timeMesure.rawValue)\(constants.weeklyMission.timeRemaning.timeValue > 1 ? "s" : "") remaining")
//                                .font(.typography(.label))
//                                .foregroundStyle(.tibbyBaseRed)
                        }
                        .padding(.bottom, 16)
                        
                        // Display the missions in the weekly mission collection
                        MissionCardComponent(missions: $constants.weeklyMission.missions)
                    }
                    Spacer()
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 33)
            }
            .scrollIndicators(.hidden)
        }
        .preferredColorScheme(.light)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
    }
}

