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
    @State var exercise: Int = UserDefaults.standard.value(forKey: "workout") as? Int ?? 30
    @State var energy: Int = UserDefaults.standard.value(forKey: "energy") as? Int ?? 110
    @State var steps: Int = UserDefaults.standard.value(forKey: "steps") as? Int ?? 500
    @State var sleep: Int = UserDefaults.standard.value(forKey: "sleep") as? Int ?? 8
    
    var body: some View {
        VStack {
            PageHeader(title: "Profile", symbol: TibbySymbols.profileBlack.rawValue)
            VStack {
                UserProfileComponent(currentTibby: $currentTibby, user: service.getUser() ?? User(id: UUID(), username: "Nat", level: 0, xp: 0))
                
                CustomDivider()
                VStack(alignment: .leading, spacing: 16) {
                    Text("Showcase")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseBlack)
                    
                    ShowcaseCard()
                    
                    CustomDivider()
                    
                    Text("My Goals")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseBlack)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 16) {
                            GoalsComponent(value: exercise, title: "Daily Exercise", description: "minutes/day")
                            GoalsComponent(value: energy, title: "Daily Energy Goal", description: "calories/day")
                            GoalsComponent(value: energy, title: "Daily Steps", description: "steps/day")
                            GoalsComponent(value: energy, title: "Daily Sleep Time", description: "hours/day")
                        }
                    }
                    
                    CustomDivider()

                    Text("My Goals")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseBlack)
                }
            }
            .padding(16)
            Spacer()
        }
        .ignoresSafeArea()
        .background(.tibbyBaseWhite)
        .navigationBarBackButtonHidden()
        .onAppear {
            self.collectionTibbies = self.collectionTibbies.sorted(by: {constants.sortRarity(rarity1: $0.rarity, rarity2: $1.rarity)})
            self.favoriteTibbies = self.setupMap()
        }
    }
    func getFavoriteTibbies(collection: String, service: Service) -> [Tibby] {
        var tibbies: [Tibby] = []
        let allTibbies = service.getAllTibbies()
        tibbies = allTibbies.filter { $0.collection == collection}
        return tibbies
    }
    
    func setupMap() -> [Collection : [Tibby]] {
        var map: [Collection : [Tibby]] = [:]
        for collection in Collection.allCases {
            map[collection] = self.getFavoriteTibbies(collection: collection.rawValue, service: service)
        }
        
        return map
    }
    
}

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .fill(.tibbyBasePearlBlue)
            .frame(height: 5)
    }
}


