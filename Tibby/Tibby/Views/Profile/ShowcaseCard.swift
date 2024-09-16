//
//  ShowcaseCard.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/09/24.
//

import SwiftUI

struct ShowcaseCard: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @State var collectionTibbies: [Tibby] = []
    @State var favoriteTibbies: [Collection:[Tibby]] = [:]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Showcase")
                .font(.typography(.body))
                .foregroundStyle(.tibbyBaseBlack)
            
            HStack {
                if service.getFavoriteTibbies().isEmpty {
                    HStack {
                        Spacer()
                        Text("You don't have any favourited Tibby. Pick your favourites to see them here.")
                            .font(.typography(.label))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.tibbyBaseGrey)
                            .frame(minHeight: 50)
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    .padding(16)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.tibbyBasePearlBlue)
                    }
                    
                } else {
                    ForEach(Array(favoriteTibbies.keys), id: \.self) { collection in
                        VStack(alignment: .leading) {
                            if !(favoriteTibbies[collection]?.isEmpty ?? false)  {
                                HStack(spacing: 4) {
                                    ForEach($collectionTibbies) { $tibby in
                                            FavoriteTibbyCard(name: $tibby.name, status: .unselected, color: collection.color, image: "\(tibby.species)1", rarity: tibby.rarity)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(12)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.tibbyBasePearlBlue)
                                }
                                .onAppear {
                                    self.collectionTibbies = self.getFavoriteTibbyList(collection: collection.rawValue, service: service)
                                    self.collectionTibbies = self.collectionTibbies.sorted(by: {constants.sortRarity(rarity1: $0.rarity, rarity2: $1.rarity)})
                                }
                            }
                        }
                        
                    }

                }
            }
        }
        .onAppear {
            self.favoriteTibbies = self.setupMap()
        }
    }
        func getFavoriteTibbyList(collection: String, service: Service) -> [Tibby] {
            var tibbies: [Tibby] = []
            let allTibbies = service.getFavoriteTibbies()
            tibbies = allTibbies.filter { $0.collection == collection}
            return tibbies
        }
        func setupMap() -> [Collection : [Tibby]] {
            var map: [Collection : [Tibby]] = [:]
            for collection in Collection.allCases {
                map[collection] = self.getFavoriteTibbyList(collection: collection.rawValue, service: service)
            }
            
            return map
        }
}
