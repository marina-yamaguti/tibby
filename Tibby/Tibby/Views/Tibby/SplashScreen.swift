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
            HomeView(tibby: service.getTibbyBySpecies(species: "yellowShark")!)
        }
    }
    
}

struct SplashScreen: View {
    @EnvironmentObject var service: Service
    @EnvironmentObject var healthManager: HealthManager
    @EnvironmentObject var constants: Constants
    @State var canProceed: Bool = false
    @State var firstTimeHere: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? false
    
    var body: some View {
        if canProceed {
            if firstTimeHere {
                OnboardingTab(firstTime: $firstTimeHere)
            }
            else {
                StartView()
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
