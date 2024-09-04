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
    @State var collectionTibbies: [Tibby] = []
    @State var tibbies: [Collection:[Tibby]] = [:]
    var body: some View {
        let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
        VStack {
            PageHeader(title: "Tibby Book", symbol: TibbySymbols.bookBlack.rawValue)
            ScrollView {
                VStack {
                    Spacer()
                    ForEach(Array(tibbies.keys), id: \.self) { collection in
                        VStack(alignment: .leading) {
                            if !(tibbies[collection]?.isEmpty ?? false)  {
                                HStack {
                                    Text(collection.rawValue)
                                        .font(.typography(.title))
                                        .foregroundStyle(.tibbyBaseBlack)
                                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                        .background {
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(collection.color)
                                        }
                                        .padding(.leading)
                                        .onAppear {
                                            self.collectionTibbies = self.getTibbyList(collection: collection.rawValue, service: service)
                                            self.collectionTibbies = self.collectionTibbies.sorted(by: {constants.sortRarity(rarity1: $0.rarity, rarity2: $1.rarity)})
                                        }
                                    Spacer()
                                }
                                .padding(.bottom, 8)
                                
                                Text(collection.description)
                                    .font(.typography(.label2))
                                    .foregroundStyle(.tibbyBaseBlack)
                                    .padding(.leading)
                                
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach($collectionTibbies) { $tibbyL in
                                        if  tibbyL.id == tibby.id {
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
                        .onAppear {
                            print(collection.rawValue)
                            print(collectionTibbies.isEmpty)
                        }
                    }
                    Spacer()
                }.padding(.top, 40)
            }.scrollIndicators(.hidden)
        }
            .ignoresSafeArea(.all, edges: .top)
            .background(Color.tibbyBaseWhite)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                self.tibbies = self.setupMap()
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

