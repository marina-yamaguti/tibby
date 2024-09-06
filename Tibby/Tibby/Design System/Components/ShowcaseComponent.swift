//
//  ShowcaseComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 05/09/24.
//

import SwiftUI

struct ShowcaseComponent: View {
    @State private var favoriteTibbies: [Tibby]
    
    init(favoriteTibbies: [Tibby]) {
        self.favoriteTibbies = favoriteTibbies
    }

    var body: some View {
        HStack {
            if favoriteTibbies.isEmpty {
                Text("You don't have any favourited Tibby. Pick your favourites to see them here.")
                    .font(.typography(.label))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.tibbyBaseGrey)
                    .frame(minHeight: 50)

                
            } else {
                    ForEach($favoriteTibbies) { $tibby in
                        TibbyCard(
                            name: $tibby.name,
                            status: .unselected,
                            color: getCollectionColor(tibby.collection),
                            image: "\(tibby.species)1",
                            rarity: tibby.rarity
                        )
                    }
                }
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 16)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.tibbyBaseDarkBlue)
        }
    }
    
    /// Function to compare Tibby collection and return the corresponding color
    /// - Parameter tibbyCollection: Receives a collection
    /// - Returns: Returns the collection's assigned color
    func getCollectionColor(_ tibbyCollection: String) -> Color {
        // Try to match the Tibby's collection string with the Collection enum
        if let collection = Collection(rawValue: tibbyCollection) {
            return collection.color // Return the color associated with the matched collection
        } else {
            return Color.gray // Default color if no match is found
        }
    }
}
