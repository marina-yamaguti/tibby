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
    @ObservedObject var tibbyView = TibbyView()
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    
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
                        if let activity = service.getActivityByName(name: "Sleep") {
                            let interaction = service.createInteraction(id: UUID(), tibbyId: tibby.id, activityId: activity.id, timestamp: Date())
                            service.applyInteractionToTibby(interaction: interaction, tibby: tibby)
                            print(tibby.sleep)
                        }
                    }
                    else {
                        let tibbySpecie = TibbySpecie(rawValue: tibby.species)
                        tibbyView.animateTibby((tibby.happiness < 33 || tibby.hunger < 33 || tibby.sleep < 33 ? tibbySpecie?.sadAnimation() : tibbySpecie?.baseAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                    }
                } label: {
                    Text("Light")
                }
                .padding()
            }
        } .onAppear {
            tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
            if constants.tibbySleeping {
                tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
            }
        }
    }
}
