//
//  HomeView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 15/07/24.
//

import SwiftUI
import SpriteKit

struct HomeView: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @State var tibby: Tibby
    @State var tibbyView = TibbyView()
    @State var navigate = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    SpriteView(scene: tibbyView as! SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                        .onAppear {
                            tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
                        }
                    Button(action: {
                        navigate.toggle()
                    }) {
                        HStack {
                            Image(Symbols.play.rawValue)
                                .padding(.trailing, 26)
                            Text("Play")
                        }
                    }
                    .buttonPrimary()
                    .navigationDestination(isPresented: $navigate) {
                        NavigationTabbarView(vm: NavigationViewModel(tibby: tibby))
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .background(
                .tibbyBaseBlue
            )
        }
        .onAppear {
            tibby.hunger = 0
            tibby.sleep = 0
            tibby.happiness = 0
        }
}
}


