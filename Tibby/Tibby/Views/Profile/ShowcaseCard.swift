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
    @State var favoriteTibbies: [Tibby] = []  // A list of all favorite Tibbies
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Showcase")
                .font(.typography(.body))
                .foregroundStyle(.tibbyBaseBlack)
            
            if favoriteTibbies.isEmpty {
                HStack {
                    Spacer()
                    Text("You don't have any favourited Tibby. Pick your favourites to see them here.")
                        .font(.typography(.label))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.tibbyBaseGrey)
                        .frame(minHeight: 100)
                    Spacer()
                }
                .padding(16)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.tibbyBasePearlBlue)
                }
            } else {
                // Show all favorite Tibbies from all collections in a single card
                HStack(spacing: 8) {
                    ForEach(favoriteTibbies.sorted(by: { constants.sortRarity(rarity1: $0.rarity, rarity2: $1.rarity) })) { tibby in
                        FavoriteTibbyCard(
                            name: tibby.name,
                            color: self.getCollectionColor(for: tibby.collection), // Get color from the collection
                            image: "\(tibby.species)1",
                            rarity: tibby.rarity
                        )
                        .scaledToFit()
                        .frame(maxWidth: 105, maxHeight: 105)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.tibbyBasePearlBlue)
                }
            }
        }
        .onAppear {
            self.favoriteTibbies = self.getAllFavoriteTibbies()
        }
    }
    
    // Function to get all favorite Tibbies without grouping by collection
    func getAllFavoriteTibbies() -> [Tibby] {
        return service.getFavoriteTibbies()
    }
    
    // Function to map a Tibby's collection string back to a Collection object and get its color
    func getCollectionColor(for collectionName: String) -> Color {
        // Assuming Collection is an enum that has a color property
        return Collection.allCases.first { $0.rawValue == collectionName }?.color ?? .black // Default to black if not found
    }
}
