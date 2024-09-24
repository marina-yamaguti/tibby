//
//  TibbyBook.swift
//  Tibby
//
//  Created by Sofia Sartori on 08/08/24.
//

import SwiftUI

struct TibbyBook: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @Binding var tibby: Tibby
    @State var tibbies: [Collection:[Tibby]] = [:]

    var body: some View {
        let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
        
        VStack(spacing: 0) {
            PageHeader(title: "Tibby Book", symbol: TibbySymbols.bookBlack.rawValue)
            ScrollView {
                VStack {
                    ForEach(Array(tibbies.keys).sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { collection in
                        VStack(alignment: .leading, spacing: 0) {
                            if !(tibbies[collection]?.isEmpty ?? false) {
                                Text(collection.rawValue)
                                    .font(.typography(.title))
                                    .foregroundStyle(.tibbyBaseBlack)
                                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .background {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(collection.color)
                                    }
                                    .padding(.leading)
                                    .padding(.bottom, 8)
                                
                                Text(collection.description)
                                    .font(.typography(.body2))
                                    .foregroundStyle(.tibbyBaseBlack)
                                    .padding(.leading)
                                
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(bindingList(collection: collection)) { $tibbyL in
                                        if tibbyL.id == tibby.id {
                                            TibbyCard(name: $tibbyL.name, status: .unselected, color: collection.color, image: "\(tibbyL.species)1", rarity: tibbyL.rarity)
                                        } else if tibbyL.isUnlocked {
                                            TibbyCard(name: $tibbyL.name, status: .unselected, color: collection.color, image: "\(tibbyL.species)1", rarity: tibbyL.rarity)
                                        } else {
                                            TibbyCard(name: $tibbyL.name, status: .locked, color: collection.color, image: "\(tibbyL.species)1", rarity: tibbyL.rarity)
                                        }
                                    }
                                }
                                .padding(16)
                                .background(.tibbyBasePearlBlue)
                                .cornerRadius(20)
                                .padding()
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.top, 40)
            }
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.tibbyBaseWhite)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.tibbies = self.setupMap()
        }
    }
    
    func bindingList(collection: Collection) -> Binding<[Tibby]> {
        Binding(
            get: { self.tibbies[collection] ?? [] },
            set: { newValue in self.tibbies[collection] = newValue }
        )
    }

    func getTibbyList(collection: String, service: Service) -> [Tibby] {
        var tibbies: [Tibby] = []
        let allTibbies = service.getAllTibbies()
        tibbies = allTibbies.filter { $0.collection == collection }
        
        tibbies.sort { (lhs, rhs) -> Bool in
            let lhsRarity = Rarity(rawValue: lhs.rarity) ?? .common
            let rhsRarity = Rarity(rawValue: rhs.rarity) ?? .common
            return lhsRarity.order < rhsRarity.order
        }
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
