//
//  KitchenView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 15/07/24.
//

import SwiftUI
import SpriteKit

struct KitchenView: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    var tibby: Tibby
    @State var isEating = false
    @State var tibbyView = TibbyView()
    @State var selectedFood: Food?
    
    @State var mouth = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/1.2)
    @GestureState var plate = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/3)
    @State var foodLocation = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/1.8)
    @State var toEat = true
    
    var platePos = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/1.8)
    
    var body: some View {
        NavigationStack {
            ZStack {
                CurvedRectangleComponent().brightness(selectedFood == nil ? -0.5 : 0)
                VStack {
                    HStack {
                        HeartsView(viewModel: HeartsViewModel(tibby: tibby, category: .hunger, service: service))
                    }.padding()
                    HStack(alignment: .center) {
                        Spacer()
                        TibbyNameComponent(name: "Shark")
                        Spacer()
                    }.padding()
                    Spacer()
                    
                    if !constants.tibbySleeping {
                        GeometryReader { reader in
                            HStack {
                                Spacer()
                                SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                                Spacer()
                            }
                            if selectedFood != nil {
                                HStack {
                                    if toEat {
                                        Image(selectedFood!.image)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .position(foodLocation)
                                            .gesture(
                                                DragGesture()
                                                    .onChanged({ state in
                                                        if !isEating {
                                                            tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.eatAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                                                            self.isEating = true
                                                        }
                                                        foodLocation = state.location
                                                        let tibbySpecie = TibbySpecie(rawValue: tibby.species)
                                                        if (foodLocation.x >= mouth.x - 100 && foodLocation.x <= mouth.x + 100 && foodLocation.y >= mouth.y - 50 && foodLocation.y <= mouth.y + 50) {
                                                            tibbyView.animateTibby((tibby.happiness < 33 || tibby.hunger < 33 || tibby.sleep < 33 ? tibbySpecie?.sadAnimation() : tibbySpecie?.baseAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                                                            
                                                            toEat = false
                                                            isEating = false
                                                            selectedFood = nil
                                                            foodLocation = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/3)
                                                            
                                                            //delete food from inventory
                                                            print(tibby.hunger)
                                                            
                                                            //update tibby hunger atribute
                                                            if let activity = service.getActivityByName(name: "Eat") {
                                                                let interaction = service.createInteraction(id: UUID(), tibbyId: tibby.id, activityId: activity.id, timestamp: Date())
                                                                service.applyInteractionToTibby(interaction: interaction, tibby: tibby)
                                                                print(tibby.hunger)
                                                                tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
                                                            }
                                                        }
                                                        
                                                    })
                                                    .onEnded({ state in
                                                        let tibbySpecie = TibbySpecie(rawValue: tibby.species)
                                                        tibbyView.animateTibby((tibby.happiness > 33 || tibby.hunger > 33 || tibby.sleep > 33 ? tibbySpecie?.sadAnimation() : tibbySpecie?.baseAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                                                        self.isEating = false
                                                        withAnimation {
                                                            foodLocation = platePos
                                                        }
                                                    })
                                            )
                                    }
                                }
                            }
                        }
                    }
                    else {
                        HStack {
                            Spacer()
                        }
                    }
                    HStack {
                        Spacer()
                        Button {
                            selectedFood = nil
                        } label: {
                            Image(Symbols.carrot.rawValue)
                        }
                        .buttonSecondary()
                        .padding()
                    }
                }.brightness(selectedFood == nil ? -0.5 : 0)
                if selectedFood == nil {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                selectedFood = service.getFoodsFromUser().keys.first
                            }, label: {
                                ZStack {
                                    Circle()
                                        .foregroundStyle(.black)
                                        .opacity(0.5)
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .foregroundStyle(.white)
                                        .padding(12)
                                }.frame(width: 40, height: 40)
                            })
                            Spacer()
                        }
                        ScrollView(.horizontal) {
                            ForEach(service.getFoodsFromUser().sorted(by: {$0.key.name < $1.key.name}), id: \.key) { key, value in
                                ZStack {
                                    VStack {
                                        Image(key.image)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .padding()
                                            .onTapGesture {
                                                self.toEat = true
                                                self.selectedFood = key
                                            }
                                    }
                                }.padding()
                            }
                        }.background(.tibbyBaseBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 45))
                            .padding()
                    }
                }
            }.onAppear {
                for accessory in service.getAllAccessories() ?? [] {
                    if tibby.id == accessory.tibbyId {
                        tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                    }
                }
                tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
                if service.getFoodsFromUser().isEmpty {
                    service.addFoodToUser(food: service.getAllFoods().first!)
                }
            }
        }
    }
}
