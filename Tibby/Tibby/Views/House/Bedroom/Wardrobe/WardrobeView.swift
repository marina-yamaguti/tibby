//
//  WardrobeView.swift
//  Tibby
//
//  Created by Sofia Sartori on 18/07/24.
//

import SwiftUI
import SpriteKit

struct WardrobeView: View {
    @State var tibbyView: TibbyProtocol = TibbyView()
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @State var selectedAccessory: Accessory?
    var tibby: Tibby
    
    var body: some View {
        VStack {
            SpriteView(scene: tibbyView as! SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
            
            HStack {
                ForEach(service.getAllAccessories() ?? []) { accessory in
                    Button {
                        tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                    } label: {
                        Text("Add \(accessory.name)")
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
        }.onChange(of: selectedAccessory, {
            if let accessory = selectedAccessory {
                if tibby.id == accessory.tibbyId {
                    tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                }
            }
        })
    }
}

