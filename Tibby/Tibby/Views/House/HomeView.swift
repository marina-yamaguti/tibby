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
    @State var tibbyView: TibbyProtocol = TibbyView()
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    SpriteView(scene: tibbyView as! SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                        .onAppear(perform: {
                            if constants.tibbySleeping {
                                tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                            }
                            else {
                                tibbyView.animateTibby((tibby.happiness > 33 || tibby.hunger > 33 || tibby.sleep > 33 ? TibbySpecie(rawValue: tibby.species)?.sadAnimation() : TibbySpecie(rawValue: tibby.species)?.baseAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                            }
                        })
                    //HomeView
                    NavigationLink {
                        NavigationTabbarView(tibby: tibby)
                    } label: {
                        Text("Play")
                    }
                    Spacer()
                }
                Spacer()
            }
            .background(
                .tibbyBaseBlue
            )
        }.onAppear {
            tibbyView.setTibby(tibbyObject: tibby, constants: constants)
        }
    }
}


