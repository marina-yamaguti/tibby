//
//  ProfileView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 02/09/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @State var showEditGoals: Bool = false
    @Binding var currentTibby: Tibby
    @State var collectionTibbies: [Tibby] = []
    @State var favoriteTibbies: [Collection:[Tibby]] = [:]
    @FocusState private var isFocused: Bool
    @State var exercise: Int = UserDefaults.standard.value(forKey: "workout") as? Int ?? 30
    @State var energy: Int = UserDefaults.standard.value(forKey: "energy") as? Int ?? 110
    @State var steps: Int = UserDefaults.standard.value(forKey: "steps") as? Int ?? 500
    @State var sleep: Int = UserDefaults.standard.value(forKey: "sleep") as? Int ?? 8

    
    var body: some View {
        ZStack {
            VStack {
                PageHeader(title: "Profile", symbol: TibbySymbols.profileBlack.rawValue)
                
                VStack(alignment: .leading, spacing: 32) {
                    UserProfileComponent(currentTibby: $currentTibby, user: service.getUser() ?? User(id: UUID(), username: "Nat", level: 0, xp: 0))
                        .frame(height: 110)
                                    
                    ShowcaseCard()
                }
                .padding(16)
                
                VStack(alignment: .leading, spacing: 32) {
                    GoalsCard(showEdit: $showEditGoals, exercise: $exercise, energy: $energy, steps: $steps, sleep: $sleep)
                }
                .padding(.leading, 16)
                Spacer()
            }
            .ignoresSafeArea()
            .background(.tibbyBaseWhite)
            .navigationBarBackButtonHidden()
            .opacity(showEditGoals ? 0.4 : 1)
            
            if showEditGoals {
                VStack {
                    Spacer()
                    EditingGoalsView(showEdit: $showEditGoals, exercise: $exercise, energy: $energy, steps: $steps, sleep: $sleep)
                        .frame(maxHeight: 644)
                }.ignoresSafeArea()
            }
        }
    }
}

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .fill(.tibbyBasePearlBlue)
            .frame(height: 2)
    }
}


