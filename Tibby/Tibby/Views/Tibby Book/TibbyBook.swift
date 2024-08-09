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
    @State var tibbies: [Tibby] = []
    @State var showPopUp = false
    @Environment(\.presentationMode) var presentationMode
    @State var collectionAlert: Collection = .seaSeries
    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Text("Tibby Book")
                        .font(.typography(.headline))
                        .padding()
                    Spacer()
                }
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Circle().foregroundStyle(.black.opacity(0.5))
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.tibbyBaseWhite)
                                .font(.system(size: 14))
                                .bold()
                                .padding()
                        }.frame(width: 30, height: 30)
                    }
                    Spacer()
                }
            }.padding()
            ScrollView {
                VStack {
                    Spacer()
                    ForEach(Collection.allCases, id: \.self) { collection in
                        VStack(alignment: .leading) {
                            let collectionTibbies = getTibbyList(collection: collection.rawValue, service: service)
                            if !collectionTibbies.isEmpty {
                                HStack {
                                    Text(collection.rawValue)
                                        .font(.typography(.title))
                                        .padding(.leading)
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
                                    ForEach(collectionTibbies) { tibbyL in
                                        if  tibbyL.id == tibby.id {
                                            ItemCard(name: tibbyL.name, status: .selected, color: collection.color, image: "\(tibbyL.species)1")
                                                .padding()
                                                
                                        } else if tibbyL.isUnlocked {
                                            ItemCard(name: tibbyL.name, status: .unselected, color: collection.color, image: "\(tibbyL.species)1")
                                                .padding()
                                        } else {
                                            ItemCard(name: tibbyL.name, status: .locked, color: collection.color, image: "\(tibbyL.species)1")
                                                .padding()
                                        }
                                    }
                                }.background(collection.color)
                                    .cornerRadius(20)
                                    .padding()
                                    .padding(.bottom, 50)       
                            }
                        }
                    }
                    Spacer()
                }.padding(.top, 40)
            }.scrollIndicators(.hidden)
        }
            .background(Color.tibbyBaseWhite)
            .navigationBarBackButtonHidden(true)
            .alert(collectionAlert.rawValue, isPresented: $showPopUp, actions: {
                Button("OK", role: .cancel) {}
            }, message: {
                Text(collectionAlert.description)
            })
    }
    func getTibbyList(collection: String, service: Service) -> [Tibby] {
        var tibbies: [Tibby] = []
        var allTibbies = service.getAllTibbies()
        tibbies = allTibbies.filter { $0.collection == collection}
        return tibbies
    }
}

