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
    @State var currentTibby: Tibby
    var body: some View {
        //to do: handle error case
        HomeView(tibby: currentTibby)
        
    }
    
}

struct SplashScreen: View {
    @EnvironmentObject var service: Service
    @EnvironmentObject var healthManager: HealthManager
    @EnvironmentObject var constants: Constants
    @State var canProceed: Bool = false
    @State var firstTimeHere: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? true
    @State var currentTibby: Tibby?
    
    var body: some View {
        NavigationStack {
            if canProceed {
                if firstTimeHere {
                    OnboardingTab(firstTime: $firstTimeHere, currentTibby: $currentTibby)
                }
                else {
                    if let tibby = self.currentTibby {
                        StartView(currentTibby: tibby)
                            .onAppear {
                                AudioManager.instance.playMusic(audio: .happy)
                            }
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
                    self.currentTibby = service.getCurrentTibby()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                        canProceed = true
                    })
                }
                .background(.tibbyBaseBlue)
            }
        }
    }
}
