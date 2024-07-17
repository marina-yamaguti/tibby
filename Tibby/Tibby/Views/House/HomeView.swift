//
//  HomeView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 15/07/24.
//

import SwiftUI
import _SpriteKit_SwiftUI
import SwiftData


struct HomeView: View {
    @State var tibbyView: TibbyProtocol = TibbyView()
    @State var selectedTibby: Tibby?
    @EnvironmentObject var service: Service
    @State var navigate: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.tibbyBaseBlue
                VStack {
                    HStack {
                        Text("Tibby Name")
                            .font(.typography(.body))
                    }
                    .padding()
                    .background(.tibbyBaseWhite)
                    .withBorderRadius(20)
                    
                    SpriteView(scene: tibbyView as! SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)

                    Button("Play", action: {})

                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            if (service.getAllTibbies()!.isEmpty) {
                service.createTibby(id: UUID(), ownerId: UUID(), rarity: "", details: "", personality: "", species: "shark", level: 0, xp: 0, happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false)
            }
            if (service.getAllAccessories()!.isEmpty) {
                service.createAccessory(id: UUID(), tibbyId: nil, name: "hat", image: "hat", price: 10)
            }
            tibbyView.animateTibby(["shark1", "shark2"], nodeID: .tibby, timeFrame: 0.5)
        }
    }
}


