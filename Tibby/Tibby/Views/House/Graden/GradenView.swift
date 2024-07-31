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
    var tibby: Tibby
    @State var tibbyView = TibbyView()
    
    var body: some View {
        ZStack {
            CurvedRectangleComponent()
            VStack {
                VStack(spacing: 8) {
                    HeartsView(viewModel: HeartsViewModel(tibby: tibby, category: .hunger, service: service))
                    TibbyNameComponent(name: "Shark")
                }
                .padding(.top, 100)
                Spacer()
                HStack {
                    Spacer()
                    if !constants.tibbySleeping {
                        SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        //sheet saing minigames coming soon
                    } label: {
                        Image(Symbols.controller.rawValue)
                    }
                    .buttonSecondary()
                    .padding()
                }
                
            }
        }
//        .toolbarBackground(.visible, for: .navigationBar)
//        .toolbarBackground(.tibbyBaseBlue, for: .navigationBar)
        .onAppear {
            for accessory in service.getAllAccessories() ?? [] {
                if tibby.id == accessory.tibbyId {
                    tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                }
            }
            tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
        }
    }
}
