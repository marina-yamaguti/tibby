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
        VStack {
            Spacer()
            HStack {
                Spacer()
                if canProceed {
                    HomeView(tibby: service.getAllTibbies().first!)
                } else {
                    VStack {
                        Image("shark1")
                            .resizable()
                            .scaledToFit()
                        Text("TIBBY")
                            .font(.typography(.title))
                    }.onAppear {
                        if service.getAllTibbies().isEmpty {
                            service.setupData()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                            canProceed = true
                        })
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .background(
            .tibbyBaseBlue
        )
        
    }
}

