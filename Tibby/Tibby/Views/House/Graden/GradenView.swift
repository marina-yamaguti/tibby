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
    @State var showSprite = false
    
    var body: some View {
        ZStack {
            CurvedRectangleComponent()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if !constants.tibbySleeping {
                        ZStack {
                            SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                                .onAppear {
                                    tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
                                }
                                .opacity(showSprite ? 1 : 0)
                            
                            if !showSprite {
                                Image("\(tibby.species)1")
                                    .resizable()
                                    .frame(width: 300, height: 300)
                            }
                        }.frame(width: 300, height: 300)
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        //sheet saing minigames coming soon
                    } label: {
                        Image(TibbySymbols.controller.rawValue)
                    }
                    .buttonSecondary(bgColor: .black)
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showSprite = true
            }
        }
    }
}
