//
//  BedroomView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 15/07/24.
//

import SwiftUI
import SpriteKit

struct BedroomView: View {
    var tibby: Tibby
    @State var tibbyView = TibbyView()
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @State var wardrobeIsOpen: Bool = false
    @State var showSprite = false
    @ObservedObject var vm: BedroomViewModel
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 45)
                .foregroundStyle(.tibbyBasePink)
            RoundedRectangle(cornerRadius: 45)
                .stroke(lineWidth: 2).foregroundStyle(.tibbyBaseBlack)
            
            Image("backgroundBedroom")
                .resizable()
                .scaledToFill()
                .opacity(0.2)
                .frame(maxWidth: UIScreen.main.bounds.width - UIScreen.main.bounds.width/16)
                .clipShape(RoundedRectangle(cornerRadius: 45))
            
            
            VStack {
                StatusBar(tibby: tibby, necessityName: "sleep")
                    .padding(.horizontal).padding(.top, 24)
                Spacer()
                ZStack {
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
                }.frame(width: 300, height: 300) //tibby
                Spacer()
                HStack {
                    Button(action: {vm.lightsOff(tibby: tibby)}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.lightbulbWhite.rawValue, text: "")})
                        .buttonSecondary(bgColor: .black.opacity(0.5))
                    Spacer()
                    Button(action: {
                        if !constants.tibbySleeping {
                            wardrobeIsOpen.toggle()
                        }
                    }, label: {ButtonLabel(type: .secondary, image: TibbySymbols.hangerWhite.rawValue, text: "")})
                        .buttonSecondary(bgColor: .black.opacity(0.5))
                }
                .padding(.bottom, 32).padding(.horizontal,20)
            }
            if wardrobeIsOpen {
                WardrobeView(tibby: tibby, wardrobeIsOpen: $wardrobeIsOpen)
            }
        }.padding().brightness(constants.brightness)
            .background(.tibbyBaseWhite)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showSprite = true
                }
            }
            .onChange(of: constants.tibbySleeping, {
                if constants.tibbySleeping {
                    if tibby.currentAccessoryId != nil {
                        tibbyView.removeAccessory {
                            print("ACCESSORY REMOVED")
                        }
                    }
                    
                    tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                } else {
                    if tibby.currentAccessoryId != nil {
                        tibbyView.addAccessory(service.getAllAccessories()!.first(where: { a in
                            a.id == tibby.currentAccessoryId
                        })!, species: tibby.species) {
                            print("ACCESSORY ADDED")
                        } remove: {
                            print("ACCESSORY REMOVED BEFORE ADD")
                        }
                    }
                    
                    let tibbySpecie = TibbySpecie(rawValue: tibby.species)
                    tibbyView.animateTibby((tibby.happiness < 33 || tibby.hunger < 33 || tibby.sleep < 33 ? tibbySpecie?.sadAnimation() : tibbySpecie?.baseAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                }
            })
            .onChange(of: wardrobeIsOpen, {
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
            })
    }
}


