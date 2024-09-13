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
    @Binding var currentTibby: Tibby
    @State var collectionTibbies: [Tibby] = []
    @State var favoriteTibbies: [Collection:[Tibby]] = [:]
    
    var body: some View {
        VStack {
            PageHeader(title: "Profile", symbol: TibbySymbols.profileBlack.rawValue)
            
            VStack(alignment: .leading, spacing: 32) {
                UserProfileComponent(currentTibby: $currentTibby, user: service.getUser() ?? User(id: UUID(), username: "Nat", level: 0, xp: 0))
                    .frame(height: 110)
                                
                ShowcaseCard()
            }
            .padding(16)
            
            VStack(alignment: .leading, spacing: 32) {
                GoalsCard()
            }
            .padding(.leading, 16)
            Spacer()
        }
        .ignoresSafeArea()
        .background(.tibbyBaseWhite)
        .navigationBarBackButtonHidden()
    }
}

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .fill(.tibbyBasePearlBlue)
            .frame(height: 5)
    }
}


