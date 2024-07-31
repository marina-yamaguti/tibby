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
    @State var status: SelectionStatus = .unselected
    var tibby: Tibby
    var columns = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        VStack {
            Spacer()
            SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
            LazyVGrid(columns: columns) {
                ForEach(service.getAllAccessories() ?? []) { accessory in
                    Button {
                        tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                    } label: {
                        ItemCard(status: .unselected, image: "\(accessory.image)-wardrobe")
                        //item card component não estava aparecendo nada pra mim, não sei porque mas acho que o name component é mt grande e não cabe aqui
                        //imagem é "\(accessory.image)-wardrobe" pra pegar a certa
                    }
                    .onChange(of: selectedAccessory, {
                        // Observes changes in the selected Tibby to update accessory interactions.
                        if tibby.id == accessory.tibbyId {
                            tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                        }
                        
                    })
                    
                }
            }
            Spacer()
        }
        .background(.tibbyBaseBlue)
        .onAppear {
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

