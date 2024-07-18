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
                HStack {
                    HeartsView(viewModel: HeartsViewModel(tibby: tibby, category: .fun, service: service))
                }.padding()
                HStack(alignment: .center) {
                    Spacer()
                    TibbyNameComponent(name: "Shark")
                    Spacer()
                }.padding()
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
        }.onAppear {
            for accessory in service.getAllAccessories() ?? [] {
                if tibby.id == accessory.tibbyId {
                    tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                }
            }
            tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
        }
    }
}
