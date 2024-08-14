//
//  TibbySelectionView.swift
//  Tibby
//
//  Created by Sofia Sartori on 07/08/24.
//

import SwiftUI

struct TibbySelectionView: View {
    @EnvironmentObject var service: Service
    @Binding var tibby: Tibby
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
            HStack {
                Spacer()
                NavigationLink(destination: { TibbyBook(tibby: $tibby)}, label: {
                    ZStack {
                        Circle().foregroundStyle(.black.opacity(0.5))
                        Rectangle().stroke(Color.tibbyBaseWhite, lineWidth: 3)
                            .padding(14)
                    }.frame(width: 40, height: 40)
                }).padding(.horizontal)
            }
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
                                    ForEach(collectionTibbies) { tibbyL in
                                        if  tibbyL.id == tibby.id {
                                            NavigationLink(destination: TibbySelectedView(viewModel: TibbySelectedViewModel(tibby: tibbyL, currentTibby: $tibby, status: .selected, service: service))) {
                                                ItemCard(name: tibbyL.name, status: .selected, color: collection.color, image: "\(tibbyL.species)1")
                                                    .padding()
                                            }
                                        } else {
                                            NavigationLink(destination: TibbySelectedView(viewModel: TibbySelectedViewModel(tibby: tibbyL, currentTibby: $tibby, status: .unselected, service: service))) {
                                                ItemCard(name: tibbyL.name, status: .unselected, color: collection.color, image: "\(tibbyL.species)1")
                                                    .padding()
                                            }
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
        .navigationBarBackButtonHidden(true)
    }
    
    func getTibbyList(collection: String, service: Service) -> [Tibby] {
        var tibbies: [Tibby] = []
        let allTibbies = service.getAllTibbies()
        tibbies = allTibbies.filter { $0.collection == collection && $0.isUnlocked }
        return tibbies
    }
}

