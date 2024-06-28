//
//  HomeView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 27/06/24.
//

import SwiftUI
import SpriteKit

struct HomeView: View {
    
    var tibby: SKScene = TibbyView()
    
    var body: some View {
        VStack {
            Text("AAA")
            SpriteView(scene: tibby, options: [.allowsTransparency])
        }
    }
}

