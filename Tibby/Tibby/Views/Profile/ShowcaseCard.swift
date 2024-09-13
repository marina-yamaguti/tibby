//
//  ShowcaseCard.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/09/24.
//

import SwiftUI

struct ShowcaseCard: View {
    @EnvironmentObject var service: Service
    @EnvironmentObject var constants: Constants
    @State var collectionTibbies: [Tibby] = []
    @State var favoriteTibbies: [Collection:[Tibby]] = [:]
    var body: some View {
        HStack {
            if favoriteTibbies.isEmpty {
                Text("You don't have any favourited Tibby. Pick your favourites to see them here.")
                    .font(.typography(.label))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.tibbyBaseGrey)
                    .padding(.vertical, 16)
            } else {
                ForEach(Array(favoriteTibbies.keys), id: \.self) { collection in
                    HStack {
                        ForEach($collectionTibbies) { $tibby in
                            TibbyCard(name: $tibby.name, status: .unselected, color: collection.color, image: "\(tibby.species)1", rarity: tibby.rarity)
                        }
                    }
                }
            }
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.tibbyBasePearlBlue)
        }
        .onAppear {
            self.favoriteTibbies = self.setupMap()
        }
    }

    func getTibbyList(collection: String, service: Service) -> [Tibby] {
        var tibbies: [Tibby] = []
        let allTibbies = service.getAllTibbies()
        tibbies = allTibbies.filter { $0.collection == collection}
        return tibbies
    }
    func setupMap() -> [Collection : [Tibby]] {
        var map: [Collection : [Tibby]] = [:]
        for collection in Collection.allCases {
            map[collection] = self.getTibbyList(collection: collection.rawValue, service: service)
        }
        
        return map
    }
}

#Preview {
    ShowcaseCard()
}
