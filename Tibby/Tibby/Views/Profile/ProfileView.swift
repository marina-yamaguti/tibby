//
//  ProfileView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 02/09/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var service: Service
    @Binding var currentTibby: Tibby
    var level: Int = 32
    var currentXp: Int = 30
    var xpToEvolve: Int = 100
    var body: some View {
        VStack(spacing: 16) {
            PageHeader(title: "Profile", symbol: TibbySymbols.profileBlack.rawValue)
            ScrollView {
                
                VStack(alignment: .leading, spacing: 16) {
                    UserInfoComponent(profileImage: "\(currentTibby.species)1", userName: service.getUser()?.username ?? " ", tibbyName: currentTibby.name, level: 2, currentXp: 2, xpToEvolve: 2)
                    
                    Rectangle()
                        .fill(.tibbyBasePearlBlue)
                        .frame(height: 5)
                    
                    Text("Showcase")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseBlack)
                    
                    HStack {
                        Spacer()
                        ShowcaseComponent(favoriteTibbies: service.getFavoriteTibbies())
                        Spacer()
                    }
                    .padding(.bottom, 16)
                    
                    Text("My Goals")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseBlack)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            GoalsComponent(value: 10, title: "Daily Exercise", description: "description")
                            GoalsComponent(value: 10, title: "Daily Exercise", description: "description")
                            GoalsComponent(value: 10, title: "Daily Exercise", description: "description")
                            GoalsComponent(value: 10, title: "Daily Exercise", description: "description")
                        }
                        .padding(.bottom, 16)
                    }
                    
                    HStack {
                        Text("Missions Streak")
                            .font(.typography(.body))
                            .foregroundStyle(.tibbyBaseBlack)
                        
                        Spacer()
                        StreakCountComponent(isOn: true, streakCount: 2)
                    }
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(1..<32) { _ in
                                StreakDayComponent(isOn: false, isToday: false, day: "2", dayOfWeek: "Mon")
                            }
                        }
                    }
                }
                .padding(16)
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}


