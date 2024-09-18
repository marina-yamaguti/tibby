//
//  MainroomView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 15/07/24.
//

import SwiftUI
import SpriteKit

struct GardenView: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @State var tibby: Tibby
    @State var tibbyView = TibbyView()
    @State var showSprite = false
    @State var exercisesSheetIsOpen = false
    @State var timeGoal: Int = UserDefaults.standard.value(forKey: "workout") as? Int ?? 30
    @State var stepsGoal: Int = UserDefaults.standard.value(forKey: "steps") as? Int ?? 500
    
    var body: some View {
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 45)
                    .foregroundStyle(.tibbyBaseGreen)
                RoundedRectangle(cornerRadius: 45)
                    .stroke(lineWidth: 2).foregroundStyle(.tibbyBaseBlack)
                
                Image("backgroundGarden")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.2)
                    .frame(maxWidth: UIScreen.main.bounds.width - UIScreen.main.bounds.width/16)
                    .clipShape(RoundedRectangle(cornerRadius: 45))
                
                
                VStack {
                    StatusBar(tibby: tibby, necessityName: "happiness")
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
                                        if tibby.id == accessory.tibbyId {
                                            tibbyView.addAccessory(accessory, species: tibby.species) {
                                                service.addAccessoryToTibby(tibbyId: tibby.id, accessory: accessory)
                                            } remove: {
                                                tibbyView.removeAccessory {
                                                    for accessory in service.getAllAccessories()! {
                                                        if accessory.tibbyId == tibby.id {
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
                        Button(action: {exercisesSheetIsOpen.toggle()}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.dumbbell.rawValue, text: "")})
                            .buttonSecondary(bgColor: .black.opacity(0.5))
                    }.padding(.bottom, 32).padding(.horizontal,20)
                }
                if constants.showFinishedWorkout {
                    ZStack {
                        RoundedRectangle(cornerRadius: 45)
                            .foregroundStyle(.tibbyBaseBlack)
                        FinishedWorkout(tibby: $tibby, showSheet: $constants.showFinishedWorkout, timeGoal: timeGoal, workoutSeconds: $constants.workoutSeconds, stepsGoal: stepsGoal, workoutSteps: $constants.workoutSteps)
                            .onAppear {
                                self.exercisesSheetIsOpen = false
                            }
                    }.padding(.top, 100)
                    
                } else {
                    if exercisesSheetIsOpen {
                        ZStack {
                            RoundedRectangle(cornerRadius: 45)
                                .foregroundStyle(.tibbyBaseBlack)
                            WorkoutListView(isOpen: $exercisesSheetIsOpen, tibby: tibby)
                        }.padding(.top, 100)
                    }
                }
            }.padding().brightness(constants.brightness)
        }.background(.tibbyBaseWhite)
            .navigationBarBackButtonHidden(true)
            .onAppear {
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
        
    }
}
