//
//  HomeView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 27/06/24.
//

import SwiftUI
import SpriteKit

struct HomeView: View {
    
    var tibby: TibbyProtocol = TibbyView()
    
    var body: some View {
        VStack {
            SpriteView(scene: tibby as! SKScene, options: [.allowsTransparency])
            
            Text("Add Accessory")
            HStack{
                Button {
//                    tibby.addAccessory("Fire")
                } label: {
                    Text("Add fire")
                }
                Button {
//                    tibby.addAccessory("Spider")
                } label: {
                    Text("Add spider")
                        .font(.fontStyle(.logo))
                }
                Button {
//                    tibby.removeAccessory()
                } label: {
                    Text("Remove")
                }

            }
        }
    }
}

