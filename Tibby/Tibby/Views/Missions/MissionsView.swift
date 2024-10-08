//
//  MissionsView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/09/24.
//

import SwiftUI

struct MissionsView: View {
    @ObservedObject var streak = GameStreak()  // Observed game streak object
    @EnvironmentObject var constants: Constants
    
    var body: some View {
        VStack(spacing: 0) {
            PageHeader(title: "Missions", symbol: TibbySymbols.listBlack.rawValue)
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Daily Mission")
                                    .font(.typography(.body))
                                    .foregroundStyle(.tibbyBaseBlack)
                            }
                            Spacer()
                            
                            // Pass the shared streak object to StreakUpComponent
                            NavigationLink(destination: StreakView()) {
                                StreakUpComponent(streak: streak)  // Pass the streak here
                            }
                        }
                        .padding(.bottom, 16)
                        
                        MissionCardComponent(missions: $constants.dailyMission.missions)
                    }
                    .padding(.bottom, 16)
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Weekly Mission")
                                .font(.typography(.body))
                                .foregroundStyle(.tibbyBaseBlack)
                        }
                        .padding(.bottom, 16)
                        
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
