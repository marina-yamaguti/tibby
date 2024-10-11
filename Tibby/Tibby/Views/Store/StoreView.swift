//  StoreView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 23/09/24.
//

import SwiftUI

struct StoreView: View {
    @ObservedObject private var gachaViewModel = GatchaViewModel()
    @EnvironmentObject var service: Service
    @EnvironmentObject var constants: Constants
    @State var accessories: [Accessory] = []
    @State var category: String = "All"
    @State var showBaseGacha: Bool = false
    @State var showSeriesGacha: Bool = false
    @State private var isBaseOnFocus: Bool = true
    @State private var isBaseNotOnFocus: Bool = false
    @State private var showConfirmationAlert: Bool = false
    @State private var selectedAccessory: Accessory?
    let categories = ["All", "Head", "Body"]


    
    
    var body: some View {
        VStack(
            spacing: 0
        ) {
            PageHeader(
                title: "Store",
                symbol: TibbySymbols.cartBlack.rawValue
            )
            .overlay {
                HStack {
                    Spacer()
                    Image("TibbyImageGem")
                        .resizable()
                        .frame(width: 22, height: 22)
                    Text("BALANCE")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseBlack)
                    Image("TibbyImageCoin")
                        .resizable()
                        .frame(width: 22, height: 22)
                    Text("BALANCE")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseBlack)
                }
            }
            ScrollView {
                VStack(
                    spacing: 16
                ) {
                    StoreSectionTitleComponent(
                        title: "Gachas",
                        backgrounImage: "StoreBackgroundBlue"
                    )
                    
                    HStack {
                        // Base Gacha Card
                        GachaCardComponent(
                            gachaType: .base,
                            title: "All\nSeries",
                            color: .tibbyBasePearlBlue,
                            image: "gatchaBase1"
                        )
                        .onTapGesture {
                            showBaseGacha = true
                        }
                        .navigationDestination(
                            isPresented: $showBaseGacha
                        ) {
                            GatchaView(
                                isBaseOnFocus: $isBaseOnFocus,
                                firstTimeHere: .constant(
                                    false
                                ),
                                currentTibby: .constant(
                                    nil
                                )
                            )
                        }
                        
                        // Series Gacha Card
                        GachaCardComponent(
                            gachaType: .series,
                            title: "Sea Series",
                            color: gachaViewModel.currentSeries.color,
                            image: "\(gachaViewModel.currentSeries.image)"
                        )
                        .onTapGesture {
                            showSeriesGacha.toggle()
                        }
                        .navigationDestination(
                            isPresented: $showSeriesGacha
                        ) {
                            GatchaView(
                                isBaseOnFocus: $isBaseNotOnFocus,
                                firstTimeHere: .constant(
                                    false
                                ),
                                currentTibby: .constant(
                                    nil
                                )
                            )
                        }
                    }
                    .padding(
                        .horizontal,
                        16
                    )
                    StoreSectionTitleComponent(
                        title: "Items",
                        backgrounImage: "StoreBackgroundPink"
                    )
                    
                    SegmentedPicker(selection: $category, categories: categories)
                        .padding(.horizontal)

                    ScrollView(
                        .horizontal
                    ) {
                        HStack(
                            spacing: 16
                        ) {
                            ForEach(
                                accessories
                            ) { accessory in
                                StoreItemComponent(image: "\(accessory.image)-wardrobe",
                                                   itemName: accessory.name,
                                                   currencyType: .coin,
                                                   price: accessory.price,
                                                   showConfirmationAlert: $showConfirmationAlert,
                                                   tapHandler:  {
                                    selectedAccessory = accessory
                                    showConfirmationAlert.toggle()
                                })
                                .frame(
                                    width: 150
                                )
                            }
                        }
                        .padding(
                            .horizontal,
                            16
                        )
                    }
                    .scrollIndicators(
                        .hidden
                    )
                    
                    StoreSectionTitleComponent(
                        title: "Currency",
                        backgrounImage: "StoreBackgroundGreen"
                    )
                    .hidden()
                }
                .padding(
                    .top,
                    16
                )
            }
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(
            .all,
            edges: .top
        )
        .background(
            .tibbyBaseWhite
        )
        .onAppear {
            self.accessories = getFilteredList()
        }
        .onChange(
            of: category
        ) { _ in
            accessories = getFilteredList()
        }
        // Present the popup conditionally
        .popup(
            isPresented: $showConfirmationAlert
        ) {
            if let selectedAccessory = selectedAccessory {
                SaleConfirmationAlert(
                    isPresented: $showConfirmationAlert,
                    image: "\(selectedAccessory.image)-wardrobe",
                    itemName: selectedAccessory.name,
                    price: selectedAccessory.price
                )
            }
        }
    }
    
    private func getFilteredList() -> [Accessory] {
        var list: [Accessory] = []
        if let filteredList = service.getAllAccessories() {
            list = filteredList
        }
        if category == "All" {
            return list.sorted(by: {
                $0.name < $1.name
            })
        }
        list = list.filter({
            $0.category == category
        }).sorted(by: {
            $0.name < $1.name
        })
        return list
    }
}
