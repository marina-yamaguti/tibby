//
//  StoreView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 23/09/24.
//

import SwiftUI

struct StoreView: View {
    @EnvironmentObject var service: Service
    @State var accessories: [Accessory] = []
    @State var category: String = "All"
    let categories = ["All", "Head", "Body"]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            PageHeader(title: "Store", symbol: TibbySymbols.cartBlack.rawValue)
            ScrollView {
                VStack(spacing: 16) {
                    StoreSectionTitleComponent(title: "Gachas", backgrounImage: "", color: .tibbyBaseBlue)
                    HStack {
                        GachaCardComponent(gachaType: .base, title: "All\nSeries", color: .tibbyBasePearlBlue, image: "gatchaBase1")
                        GachaCardComponent(gachaType: .series, title: Collection.seaSeries.rawValue, color: Collection.seaSeries.color, image: "gatchaSeaSeries1")
                    }
                    .padding(.horizontal, 16)
                    StoreSectionTitleComponent(title: "Items", backgrounImage: "", color: .tibbyBasePink)
                    ScrollView(.horizontal) {
                        LazyVGrid(columns: columns) {
                            ForEach(accessories) { accessory in
                                StoreItemComponent(image: "\(accessory.image)-wardrobe", itemName: accessory.name, currencyType: .coin, price: accessory.price)
                                    .frame(width: 150)
                            }
                        }
                        
                    }
                    
                }
                
            }
            
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        .onAppear {
            self.accessories = getFilteredList()
        }
        .onChange(of: category, {
            accessories = getFilteredList()
        })
    }
    private func getFilteredList() -> [Accessory] {
        var list: [Accessory] = []
        if let filteredList = service.getAllAccessories() {
            list = filteredList
        }
        if category == "All" {
            return list.sorted(by: {$0.name < $1.name})
        }
        list = list.filter({$0.category == category}).sorted(by: {$0.name < $1.name})
        return list
    }
    
}


#Preview {
    StoreView()
}



