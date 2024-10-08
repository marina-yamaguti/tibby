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
    @State var showSprite = false
    @State var isEating = false
    @State var tibbyView = TibbyView()
    @State var selectedFood: Food?
    @State var openSelector = false
    @State var mouth = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/3.5)
    @GestureState var plate = CGPoint(x: UIScreen.main.bounds.width/2 - UIScreen.main.bounds.width/20, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/2.5)
    @State var foodLocation = CGPoint(x: UIScreen.main.bounds.width/2 - UIScreen.main.bounds.width/20, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/2.15)
    @State var toEat = true
    var platePos = CGPoint(x: UIScreen.main.bounds.width/2 - UIScreen.main.bounds.width/20, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/2.15)
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 45)
                    .foregroundStyle(.tibbyBaseBlue)
                RoundedRectangle(cornerRadius: 45)
                    .stroke(lineWidth: 2).foregroundStyle(.tibbyBaseBlack)
                
                Image("backgroundKitchen")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.2)
                    .frame(maxWidth: UIScreen.main.bounds.width - UIScreen.main.bounds.width/16)
                    .clipShape(RoundedRectangle(cornerRadius: 45))
                
                
                VStack {
                    StatusBar(tibby: tibby, necessityName: "hunger")
                        .padding(.horizontal).padding(.top, 24)
                    Spacer()
                    ZStack {
                        if constants.tibbySleeping {
                            Spacer()
                        } else {
                            SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                                .opacity(showSprite ? 1 : 0)
                                .onAppear {
                                    tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
                                    for accessory in service.getAllAccessories() ?? [] {
                                        if accessory.id == tibby.currentAccessoryId {
                                            tibbyView.addAccessory(accessory, species: tibby.species) {
                                                service.addAccessoryToTibby(tibbyId: tibby.id, accessory: accessory)
                                            } remove: {
                                                tibbyView.removeAccessory {
                                                    for accessory in service.getAllAccessories()! {
                                                        if accessory.id == tibby.currentAccessoryId {
                                                            service.removeAccessoryFromTibby(accessory: accessory)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                    if constants.tibbySleeping {
                                        tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                                    }
                                }
                            if !showSprite {
                                Image("\(tibby.species)1")
                                    .resizable()
                                    .frame(width: 300, height: 300)
                                    .hidden()
                            }
                        }
                    }.frame(width: 300, height: 300) //tibby
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {openSelector.toggle()}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.carrotWhite.rawValue, text: "")})
                            .buttonSecondary(bgColor: .black.opacity(0.5))
                    }
                    .padding(.bottom, 32).padding(.horizontal,20)
                }
                Image("plate")
                    .resizable()
                    .frame(width: 120.55, height: 23.23)
                    .position(plate)
                if !openSelector && selectedFood != nil {
                    HStack {
                        if toEat {
                            Image(selectedFood!.image)
                                .resizable()
                                .frame(width: 75, height: 75)
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
                                            if (foodLocation.x >= mouth.x - 100 && foodLocation.x <= mouth.x + 100 && foodLocation.y >= mouth.y - 100 && foodLocation.y <= mouth.y + 100) {
                                                tibbyView.animateTibby((tibby.happiness < 33 || tibby.hunger < 33 || tibby.sleep < 33 ? tibbySpecie?.sadAnimation() : tibbySpecie?.baseAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                                                if self.toEat {
                                                    self.toEat = false
                                                    self.eat()
                                                    
                                                    var missionsDaily = constants.dailyMission.getMissions()

                                                    for i in 0 ..< missionsDaily.count {
                                                        if missionsDaily[i].missionType == .feed {
                                                            print(missionsDaily[i].valueDone)
                                                            if missionsDaily[i].valueDone < missionsDaily[i].valueTotal {
                                                                missionsDaily[i].updateProgress(value: 1)
                                                            }
                                                            print(missionsDaily[i].valueDone)
                                                        }
                                                    }
                                                    constants.dailyMission.missions = missionsDaily
                                                    
                                                    var missionsWeekly = constants.weeklyMission.getMissions()

                                                    for i in 0 ..< missionsWeekly.count {
                                                        if missionsWeekly[i].missionType == .feed {
                                                            print(missionsWeekly[i].valueDone)
                                                            if missionsWeekly[i].valueDone < missionsWeekly[i].valueTotal {
                                                                missionsWeekly[i].updateProgress(value: 1)
                                                            }
                                                            print(missionsWeekly[i].valueDone)
                                                        }
                                                    }
                                                    constants.weeklyMission.missions = missionsWeekly
                                                    
                                                    self.foodLocation = platePos
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                    self.toEat = true
                                                }
                                                
                                                //delete food from inventory
                                                print(tibby.hunger)
                                                
                                                //update tibby hunger atribute
                                                if let activity = service.getActivityByName(name: "Eat") {
                                                    let interaction = service.createInteraction(id: UUID(), tibbyId: tibby.id, activityId: activity.id, timestamp: Date())
                                                    service.applyInteractionToTibby(interaction: interaction, tibby: tibby)
                                                    tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
                                                }
                                            }
                                            
                                        })
                                        .onEnded({ state in
                                            let tibbySpecie = TibbySpecie(rawValue: tibby.species)
                                            tibbyView.animateTibby((tibby.happiness < 33 || tibby.hunger < 33 || tibby.sleep < 33 ? tibbySpecie?.sadAnimation() : tibbySpecie?.baseAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                                            self.isEating = false
                                            withAnimation {
                                                foodLocation = platePos
                                            }
                                            self.toEat = true
                                        })
                                )
                        }
                    }
                }
                if openSelector {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                openSelector = false
                                HapticManager.instance.impact(style: .soft)
                                AudioManager.instance.playSFX(audio: .secondaryButton)
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
                            HStack(spacing: 16) {
                                ForEach(service.getFoodsFromUser().sorted(by: {$0.key.name < $1.key.name}), id: \.key) { key, value in
                                    Image(key.image)
                                        .resizable()
                                        .frame(width: 70, height: 61)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .onTapGesture {
                                            self.toEat = true
                                            self.selectedFood = key
                                            self.openSelector = false
                                        }
                                }.padding()
                            }
                        }.background(.tibbyBaseBlack)
                            .frame(height: 94)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                    }
                } //food selector
            }.padding().brightness(constants.brightness)
        }.background(.tibbyBaseWhite)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                print(service.getAllFoods().count)
                print(service.getFoodsFromUser().count)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showSprite = true
                }
            }
            .onChange(of: constants.tibbySleeping, {
                if constants.tibbySleeping {
                    tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                } else {
                    let tibbySpecie = TibbySpecie(rawValue: tibby.species)
                    tibbyView.animateTibby((tibby.happiness < 33 || tibby.hunger < 33 || tibby.sleep < 33 ? tibbySpecie?.sadAnimation() : tibbySpecie?.baseAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                }
            })
            .onChange(of: selectedFood, {
                print(selectedFood?.name)
            })
    }
    
    func eat() {
        self.isEating = false
        if !(service.getFoodsFromUser()[selectedFood!] ?? 0 > 0) {
            if let newFood = service.getFoodsFromUser().first?.key {
                self.selectedFood = newFood
            }
        }
    }
}
