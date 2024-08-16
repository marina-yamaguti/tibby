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
    @State var tibbies: [Collection:[Tibby]] = [:]
    @State var tibbyCollection: [Tibby] = []
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
                        Image("TibbySymbolBook")
                            .resizable()
                            .frame(width:14, height: 14)
                    }.frame(width: 40, height: 40)
                }).padding(.horizontal).hidden()
            }
            ScrollView {
                VStack {
                    Spacer()
                    ForEach(Array(tibbies.keys), id: \.self) { collection in
                        VStack(alignment: .leading) {
                            if !(tibbies[collection]?.isEmpty ?? false)  {
                                Text(collection.rawValue)
                                    .font(.typography(.title))
                                    .foregroundStyle(Color.tibbyBaseBlack)
                                    .padding(.leading)
                                    .onAppear {
                                        self.tibbyCollection = self.getTibbyList(collection: collection.rawValue, service: service)
                                    }
                                LazyVGrid(columns: columns, spacing: 8) {
                                    ForEach($tibbyCollection) { $tibbyL in
                                        if  tibbyL.id == tibby.id {
                                            NavigationLink(destination: TibbySelectedView(viewModel: TibbySelectedViewModel(tibby: $tibbyL, currentTibby: $tibby, status: .selected, service: service))) {
                                                ItemCard(name: $tibbyL.name, status: .selected, color: collection.color, image: "\(tibbyL.species)1")
                                                    .padding()
                                            }
                                        } else {
                                            NavigationLink(destination: TibbySelectedView(viewModel: TibbySelectedViewModel(tibby: $tibbyL, currentTibby: $tibby, status: .unselected, service: service))) {
                                                ItemCard(name: $tibbyL.name, status: .unselected, color: collection.color, image: "\(tibbyL.species)1")
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
        .onChange(of: tibbies, {print("algum tibby mudou")})
        .background(Color.tibbyBaseWhite)
        .offset(y: showSheet ? 0 : UIScreen.main.bounds.height)
        .animation(.easeInOut, value: showSheet)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.tibbies = self.setupMap()
        }
    }
    
    func getTibbyList(collection: String, service: Service) -> [Tibby] {
        var tibbies: [Tibby] = []
        let allTibbies = service.getAllTibbies()
        tibbies = allTibbies.filter { $0.collection == collection && $0.isUnlocked }
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
