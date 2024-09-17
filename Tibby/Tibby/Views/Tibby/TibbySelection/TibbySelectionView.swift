//
//  TibbySelectionView.swift
//  Tibby
//
//  Created by Sofia Sartori on 07/08/24.
//

import SwiftUI

struct TibbySelectionView: View {
    @EnvironmentObject var service: Service
    @EnvironmentObject var constants: Constants
    @Binding var tibby: Tibby
    @State var tibbies: [Collection:[Tibby]] = [:]
    @Binding var showSheet: Bool
    @State var sheetHeight: CGFloat = 100
    @State var navigate: Bool = false
    @State private var showTibbyBook = false
    
    var body: some View {
        let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
        VStack {
            SheetWithCircle(goingUp: false)
                .ignoresSafeArea(.all)
                .frame(height: sheetHeight)
                .onTapGesture {
                    withAnimation {
                        showSheet.toggle()
                    }
                }
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
                Button(action: {showTibbyBook = true}, label: {ButtonLabel(type: .secondary, image: "TibbySymbolBook", text: "")})
                    .buttonSecondary(bgColor: .black.opacity(0.5))
                    .navigationDestination(isPresented: $showTibbyBook) {
                        TibbyBook(tibby: $tibby)
                    }
            }
            .padding(.horizontal)
            ScrollView {
                VStack {
                    Spacer()
                    ForEach(Array(tibbies.keys), id: \.self) { collection in
                        VStack(alignment: .leading) {
                            if !(tibbies[collection]?.isEmpty ?? false)  {
                                HStack(alignment: .center) {
                                    CollectionNameComponent(name: collection.rawValue, color: collection.color)
                                        .padding(.bottom, 16)
                                    Spacer()
                                }
                                
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(bindingList(collection: collection)) { $tibbyL in
                                        if tibbyL.id == tibby.id {
                                            NavigationLink(destination: TibbySelectedView(viewModel: TibbySelectedViewModel(tibby: $tibbyL, currentTibby: $tibby, status: .selected, service: service))) {
                                                TibbyCard(name: $tibbyL.name, status: .selected, color: collection.color, image: "\(tibbyL.species)1", rarity: tibbyL.rarity)
                                            }
                                        } else {
                                            NavigationLink(destination: TibbySelectedView(viewModel: TibbySelectedViewModel(tibby: $tibbyL, currentTibby: $tibby, status: .unselected, service: service))) {
                                                TibbyCard(name: $tibbyL.name, status: .unselected, color: collection.color, image: "\(tibbyL.species)1", rarity: tibbyL.rarity)
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .background(.tibbyBasePearlBlue)
                                .cornerRadius(20)
                                .padding(.bottom, 50)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .onChange(of: tibbies, {print("algum tibby mudou")})
        .background(Color.tibbyBaseWhite)
        .offset(y: showSheet ? 0 : UIScreen.main.bounds.height)
        .animation(.easeInOut, value: showSheet)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            print("my tibbies: ")
            self.tibbies = self.setupMap()
            for collection in tibbies.keys {
                print("coleção: \(collection.rawValue)")
                print(tibbies[collection]?.count)
            }
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
        tibbies = allTibbies.filter { $0.collection == collection && $0.isUnlocked == true}
        
        tibbies.sort { (lhs, rhs) -> Bool in
            let lhsRarity = Rarity(rawValue: lhs.rarity) ?? .common
            let rhsRarity = Rarity(rawString: rhs.rarity) ?? .common
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
