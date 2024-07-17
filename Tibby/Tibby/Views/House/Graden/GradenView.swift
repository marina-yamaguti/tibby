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
    var tibby: Tibby
    @State var tibbyView: TibbyProtocol = TibbyView()
    
    var body: some View {
        VStack {
            Text("Garden")
                .font(.typography(.title))
            Spacer()
            HStack {
                Spacer()
                if !constants.tibbySleeping {
                    SpriteView(scene: tibbyView as! SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                }
                Spacer()
            }
            Spacer()
        } .onAppear {
            tibbyView.setTibby(tibbyObject: tibby, constants: constants)
        }
    }
}
