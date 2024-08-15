//
//  TibbyBook.swift
//  Tibby
//
//  Created by Sofia Sartori on 08/08/24.
//

import SwiftUI

struct TibbyBook: View {
    @EnvironmentObject var service: Service
    @Binding var tibby: Tibby
    @State var showPopUp = false
    @State var collectionAlert: Collection = .seaSeries
    @State var collectionTibbies: [Tibby] = []
    @State var tibbies: [Collection:[Tibby]] = [:]
    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        VStack {
            PageHeader(title: "Tibby Book", symbol: "TibbySymbolBook")
            ScrollView {
                VStack {
                    Spacer()
                    ForEach(Array(tibbies.keys), id: \.self) { collection in
                        VStack(alignment: .leading) {
                            if !(tibbies[collection]?.isEmpty ?? false)  {
                                HStack {
                                    Text(collection.rawValue)
                                        .font(.typography(.title))
                                        .padding(.leading)
                                        .onAppear {
                                            self.collectionTibbies = self.getTibbyList(collection: collection.rawValue, service: service)
                                        }
                                        
                                    Spacer()
                                    Button(action: {
                                        self.collectionAlert = collection
                                        showPopUp.toggle()
                                    }, label: {
                                        ZStack {
                                            Circle().foregroundStyle(.black.opacity(0.5))
                                            Text("?").foregroundStyle(.tibbyBaseWhite)
                                                .padding(4)
                                        }.frame(width: 24, height: 24)
                                    }).padding(.trailing)
                                }
                                LazyVGrid(columns: columns, spacing: 8) {
                                    ForEach($collectionTibbies) { $tibbyL in
                                        if  tibbyL.id == tibby.id {
                                            ItemCard(name: $tibbyL.name, status: .selected, color: collection.color, image: "\(tibbyL.species)1")
                                                .padding()
                                                
                                        } else if tibbyL.isUnlocked {
                                            ItemCard(name: $tibbyL.name, status: .unselected, color: collection.color, image: "\(tibbyL.species)1")
                                                .padding()
                                        } else {
                                            ItemCard(name: $tibbyL.name, status: .locked, color: collection.color, image: "\(tibbyL.species)1")
                                                .padding()
                                        }
                                    }
                                }.background(collection.color)
                                    .cornerRadius(20)
                                    .padding()
                                    .padding(.bottom, 50)       
                            }
                        }.onAppear {
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
            .alert(collectionAlert.rawValue, isPresented: $showPopUp, actions: {
                Button("OK", role: .cancel) {}
            }, message: {
                Text(collectionAlert.description)
            })
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

