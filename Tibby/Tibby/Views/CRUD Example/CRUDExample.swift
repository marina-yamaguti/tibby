//
//  CRUDExample.swift
//  Tibby
//
//  Created by Sofia Sartori on 02/07/24.
//

import SwiftUI
import SwiftData
import SpriteKit

struct CRUDExample: View {
    
    // MARK: - Properties
    
    /// Represents the view responsible for displaying Tibby.
    @State var tibbyView: TibbyProtocol = TibbyView()
    
    /// Holds the currently selected Tibby object.
    @State var selectedTibby: Tibby?
    
    /// Service object responsible for data operations.
    @EnvironmentObject var service: Service
    
    @State var tibbySpecie: TibbySpecie?

    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                // Displays the Tibby view using SpriteKit.
                SpriteView(scene: tibbyView as! SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                
                // Interface for adding accessories to Tibby.
                HStack {
                    ForEach(service.getAllAccessories() ?? []) { accessory in
                        // Button to add the accessory to the Tibby view.
                        Button {
                            if let selectedTibby {
                                tibbyView.addAccessory(accessory, service, tibbyID: selectedTibby.id)
                            }
                        } label: {
                            Text("Add \(accessory.name)")
                        }
                          .onChange(of: selectedTibby, {
                            // Observes changes in the selected Tibby to update accessory interactions.
                            if let selectedTibby {
                                if selectedTibby.id == accessory.tibbyId {
                                    tibbyView.addAccessory(accessory, service, tibbyID: selectedTibby.id)
                                }
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
            }
            
            // List of Tibbies displayed in the navigation stack.
            List {
                ForEach(service.getAllTibbies()) { tibby in
                    VStack(alignment: .leading) {
                        Text(tibby.species)
                            .font(.headline)
                    }.onAppear {
                        self.selectedTibby = tibby
                    }
                }
            }
            .navigationTitle("Tibby")
        }
        .onAppear {
            ///Exemple of creating only one instance of shark and hat and animate it
            if (service.getAllTibbies().isEmpty) {
                service.createTibby(id: UUID(), ownerId: UUID(), rarity: "", details: "", personality: "", species: "shark", level: 0, xp: 0, happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false)
            }
            if (service.getAllAccessories()!.isEmpty) {
                service.createAccessory(id: UUID(), tibbyId: nil, name: "hat", image: "hat", price: 10)
            }
            tibbyView.setTibbySpecie(tibbySpecie: TibbySpecie(rawValue: (selectedTibby?.species) ?? "shark") ?? .shark)
        }
    }
}
