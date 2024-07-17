//
//  HomeView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 15/07/24.
//

import SwiftUI
import SpriteKit

struct HomeView: View {
    @EnvironmentObject var service: Service
    @State var tibby: Tibby
    @State var tibbyView: TibbyProtocol = TibbyView()
    
    var body: some View {
        NavigationStack {
            VStack {
                SpriteView(scene: tibbyView as! SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                //HomeView
                NavigationLink {
                    NavigationTabbarView(tibby: tibby)
                } label: {
                    Text("Play")
                }
            }
        }.onAppear {
            tibbyView.animateTibby(["shark1", "shark2"], nodeID: .tibby, timeFrame: 0.5)
        }
    }
}


