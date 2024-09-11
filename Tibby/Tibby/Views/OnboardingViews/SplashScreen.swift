//
//  SplashScreen.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/07/24.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    var body: some View {
        //change this to initializa with the right tibby
        if let currentTibby = service.getTibbyByID(id: service.getUser()?.currentTibbyID ?? UUID()) {
            HomeView(tibby: currentTibby)
        } else {
            HomeView(tibby: service.getTibbyBySpecies(species: "shark")!)
        }
    }
    
}

struct SplashScreen: View {
    @EnvironmentObject var service: Service
    @EnvironmentObject var healthManager: HealthManager
    @EnvironmentObject var constants: Constants
    @State var canProceed: Bool = false
    @State var firstTimeHere: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? true
    
    var body: some View {
        NavigationStack {
            if canProceed {
                if firstTimeHere {
                    OnboardingTab(firstTime: $firstTimeHere)
                }
                else {
                    StartView()
                        .onAppear {
                            AudioManager.instance.playMusic(audio: .happy)
                        }
                }
            } else {
                VStack {
                    Spacer()
                    Image("TibbyLogoFull")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
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
}