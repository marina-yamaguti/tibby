//
//  WardrobeView.swift
//  Tibby
//
//  Created by Sofia Sartori on 18/07/24.
//

import SwiftUI
import SpriteKit

struct WardrobeView: View {
    @State var tibbyView = TibbyView()
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @State var selectedAccessory: Accessory?
    var tibby: Tibby
    
    var body: some View {
        VStack {
            SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
            
            HStack {
                ForEach(service.getAllAccessories() ?? []) { accessory in
                    Button {
                        tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                    } label: {
                        VStack {
                            Image("\(accessory.image)-wardrobe")
                                .resizable()
                                .frame(width: 100, height: 100)
                            Text("Add \(accessory.name)")
                        }
                    }
                    .onChange(of: tibby, {
                        // Observes changes in the selected Tibby to update accessory interactions.
                        if tibby.id == accessory.tibbyId {
                            tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                        }
                        
                    })
                    
                }
                // Button to remove the accessory from Tibby view.
                Button {
                    tibbyView.removeAccessory(service)
                } label: {
                    Text("Remove")
                }
                
            }
        }.onAppear {
            for accessory in service.getAllAccessories() ?? [] {
                if tibby.id == accessory.tibbyId {
                    tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                    selectedAccessory = accessory
                }
            }
            tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
            if constants.tibbySleeping {
                tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
            }
        }
        .onChange(of: selectedAccessory, {
            if let accessory = selectedAccessory {
                if tibby.id == accessory.tibbyId {
                    tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                }
            }
        })
    }
}

