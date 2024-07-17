//
//  Kitchen.swift
//  Tibby
//
//  Created by Sofia Sartori on 08/07/24.
//

import SwiftUI

struct KitchenExample: View {
    
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @State var selectedTibby: Tibby?
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(service.getAllTibbies()) { tibby in
                    VStack(alignment: .leading) {
                        Text("my food inventory: ").font(.title)
                        ForEach(service.getFoodsFromUser().sorted(by: {$0.key.name < $1.key.name}), id: \.key) { key, value in
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.gray)
                                VStack {
                                    Image(key.image)
                                        .resizable()
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .padding()
                                    Text(key.name)
                                    Text("quantity: \(value)")
                                }
                            }.padding()
                        }
                            
                    }.onAppear {
                        self.selectedTibby = tibby
                    }
                }.padding()
                ForEach(service.getAllFoods()) { food in
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.gray)
                            VStack {
                                Image(food.image)
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .padding()
                                Text(food.name)
                                Text("price: \(food.price)")
                            }
                        }.padding()
                        Button(action: {
                            service.addFoodToUser(food: food)
                        }, label: {
                            Text("uau quero comprar \(food.name)")
                        })
                        Button(action: {
                            service.removeFoodFromUser(food: food)
                        }, label: {
                            Text("uau quero devolver \(food.name)")
                        })
                    }
                }
                NavigationLink {
                    BedroomExemple()
                        .brightness(constants.brightness)
                } label: {
                    Text("Bedroom")
                }
            }.onAppear {
                if(service.getAllUsers().isEmpty) {
                    service.createUser(id: UUID(), username: "sofia")
                }
                if(service.getAllFoods().isEmpty) {
                    service.createFood(id: UUID(), name: "Pizza", image: "pizza", price: 10)
                }
                if (service.getAllTibbies().isEmpty) {
                    service.createTibby(id: UUID(), ownerId: service.getUser()?.id, rarity: "", details: "", personality: "", species: "shark", level: 0, xp: 0, happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false)
                }
                print(service.getFoodsFromUser())
                print(service.getFoodsIDsFromUser())
            }
            
            .brightness(constants.brightness)
        }
    }
}

