//
//  SplashScreen.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/07/24.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var service: Service
    @State var canProceed: Bool = false
    
    var body: some View {
        if canProceed {
            //change this to initializa with the right tibby
            HomeView(tibby: service.getAllTibbies().first!)
        } else {
            VStack {
                Spacer()
                Image("shark1")
                    .resizable()
                    .scaledToFit()
                Text("TIBBY")
                    .font(.typography(.title))
                Spacer()
            }.onAppear {
                service.setupData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                    canProceed = true
                })
            }
            .background(.tibbyBaseBlue)
        }
    }
}

