//
//  TibbySelectionView.swift
//  Tibby
//
//  Created by Sofia Sartori on 07/08/24.
//

import SwiftUI

struct TibbySelectionView: View {
    @EnvironmentObject var service: Service
    @State var tibby: Tibby
    @State var tibbies: [Tibby] = []
    @Binding var showSheet: Bool
    @State var sheetHeight: CGFloat = 100
    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        VStack {
            SheetWithCircle(goingUp: false)
                .ignoresSafeArea(.all)
                .frame(height: sheetHeight)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if showSheet {
                                let newHeight = sheetHeight - value.translation.height * -1
                                sheetHeight = max(100, newHeight)
                                print(sheetHeight)
                                if sheetHeight > 250 {
                                    withAnimation {
                                        showSheet.toggle()
                                    }
                                }
                            }
                        }
                        .onEnded { state in
                            sheetHeight = 100
                        }
                )
            ScrollView {
                VStack {
                    Spacer()
                    ForEach(Collection.allCases, id: \.self) { collection in
                        VStack(alignment: .leading) {
                            let collectionTibbies = getTibbyList(collection: collection.rawValue, service: service)
                            if !collectionTibbies.isEmpty {
                                Text(collection.rawValue)
                                    .font(.typography(.title))
                                    .padding(.leading)
                                LazyVGrid(columns: columns, spacing: 8) {
                                    ForEach(collectionTibbies) { tibby in
                                        if service.getUser()?.currentTibbyID == tibby.id {
                                            ItemCard(name: tibby.species, status: .selected, color: collection.color, image: "\(tibby.species)1")
                                                .padding()
                                        } else {
                                            ItemCard(name: tibby.name, status: .unselected, color: collection.color, image: "\(tibby.species)1")
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
                }
            }
        }
            .background(Color.tibbyBaseWhite)
            .offset(y: showSheet ? 0 : UIScreen.main.bounds.height)
            .animation(.easeInOut, value: showSheet)
    }
    
    func getTibbyList(collection: String, service: Service) -> [Tibby] {
        var tibbies: [Tibby] = []
        var allTibbies = service.getAllTibbies()
        tibbies = allTibbies.filter { $0.collection == collection && $0.isUnlocked }
        return tibbies
    }
}

