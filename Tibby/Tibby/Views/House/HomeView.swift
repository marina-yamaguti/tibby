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
            ZStack {
                Color.tibbyBaseBlue
                VStack {
                    StyledPicker()
                    Text("Tibby Name")
                    SpriteView(scene: tibbyView as! SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                    //HomeView
                    NavigationLink {
                        NavigationTabbarView(tibby: tibby)
                    } label: {
                        Text("Play")
                    }
                }
            }
            .ignoresSafeArea()
        }.onAppear {
            tibbyView.animateTibby(["shark1", "shark2"], nodeID: .tibby, timeFrame: 0.5)
        }
    }
}


