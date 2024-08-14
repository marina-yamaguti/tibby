//
//  SplashScreen.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/07/24.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var service: Service
    @EnvironmentObject var healthManager: HealthManager
    @State var canProceed: Bool = false
    @State var firstTimeHere: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? true
    
    var body: some View {
        if canProceed {
            if firstTimeHere {
                OnboardingTab(firstTime: $firstTimeHere)
            }
            else {
                //change this to initializa with the right tibby
                
                HomeView(tibby: service.getTibbyBySpecies(species: "yellowShark")!)
            }
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
                if !firstTimeHere {
                    healthManager.fetchAllInformation()
                }
                service.setupData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                    canProceed = true
                })
            }
            .background(.tibbyBaseBlue)
        }
    }
}

