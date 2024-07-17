//
//  BedroomView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 15/07/24.
//

import SwiftUI
import SpriteKit

struct BedroomView: View {
    
    var tibby: Tibby
    @State var tibbyView: TibbyProtocol = TibbyView()
    @EnvironmentObject var constants: Constants
    
    var body: some View {
        VStack {
            Text("Bedroom")
                .font(.typography(.title))
            Spacer()
            SpriteView(scene: tibbyView as! SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
            Spacer()
            HStack {
                Button {
                    //
                } label: {
                    Text("Clothes")
                }
                .padding()
                Spacer()
                Button {
                    constants.tibbySleeping.toggle()
                    if constants.tibbySleeping {
                        tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                    }
                    else {
                        let tibbySpecie = TibbySpecie(rawValue: tibby.species)
                        tibbyView.animateTibby((tibby.happiness > 33 || tibby.hunger > 33 || tibby.sleep > 33 ? tibbySpecie?.sadAnimation() : tibbySpecie?.baseAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                    }
                } label: {
                    Text("Light")
                }
                .padding()
            }
        } .onAppear {
            tibbyView.setTibby(tibbyObject: tibby, constants: constants)
            if constants.tibbySleeping {
                tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
            }
        }
    }
}
