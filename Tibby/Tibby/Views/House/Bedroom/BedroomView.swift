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
    
    var body: some View {
        VStack {
            ZStack {
                CurvedRectangleComponent()
                VStack {
                    VStack(spacing: 16) {
                        HeartsView(viewModel: HeartsViewModel(tibby: tibby, category: .hunger, service: service))
                        TibbyNameComponent(name: "Shark")
                    }
                    .padding(.top, 100)
                    
                    SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                        .onAppear {
                            tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
                            for accessory in service.getAllAccessories() ?? [] {
                                if tibby.id == accessory.tibbyId {
                                    tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                                }
                            }
                            
                            if constants.tibbySleeping {
                                tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                            }
                        }
                    Spacer()
                    HStack {
                        Button {
                            constants.tibbySleeping.toggle()
                            if constants.tibbySleeping {
                                print("mimiu")
                                tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                                if let activity = service.getActivityByName(name: "Sleep") {
                                    let interaction = service.createInteraction(id: UUID(), tibbyId: tibby.id, activityId: activity.id, timestamp: Date())
                                    service.applyInteractionToTibby(interaction: interaction, tibby: tibby)
                                    print(tibby.sleep)
                                }
                            }
                            else {
                                let tibbySpecie = TibbySpecie(rawValue: tibby.species)
                                tibbyView.animateTibby((tibby.happiness < 33 || tibby.hunger < 33 || tibby.sleep < 33 ? tibbySpecie?.sadAnimation() : tibbySpecie?.baseAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                            }
                        } label: {
                            Image(Symbols.lightBulb.rawValue)
                        }
                        .buttonSecondary()
                        .padding()
                        Spacer()
                        Button {
                            wardrobeIsOpen = true
                        } label: {
                            Image(Symbols.hanger.rawValue)
                        }
                        .buttonSecondary()
                        .padding()
                    }
                }
//                .toolbarBackground(.visible, for: .navigationBar)
//                .toolbarBackground(.tibbyBaseBlue, for: .navigationBar)
                .onChange(of: constants.tibbySleeping, {
                    if constants.tibbySleeping {
                        tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                    }
                })
            }
        }
    }
}


