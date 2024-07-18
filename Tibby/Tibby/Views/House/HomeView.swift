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
    @ObservedObject var tibbyView = TibbyView()
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    SpriteView(scene: tibbyView as! SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                    //HomeView
                    NavigationLink {
                        NavigationTabbarView(vm: NavigationViewModel(tibby: tibby))
                    } label: {
                        Text("Play")
                    }
                    Spacer()
                }
                Spacer()
            }
            .ignoresSafeArea()
        }.onAppear {
            tibby.hunger = 0
            tibby.sleep = 0
            tibby.happiness = 0
            tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
        }
    }
}


