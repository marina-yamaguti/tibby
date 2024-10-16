//
//  SplashScreen.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/07/24.
//

import SwiftUI
import Network

struct StartView: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @State var currentTibby: Tibby
    
    var body: some View {
        HomeView(tibby: currentTibby)
    }
}

import SwiftUI
import Network

struct SplashScreen: View {
    @EnvironmentObject var service: Service
    @EnvironmentObject var healthManager: HealthManager
    @EnvironmentObject var constants: Constants
    @ObservedObject var networkMonitor = NetworkMonitor.shared  // Monitor network connectivity
    @State var canProceed: Bool = false
    @State var firstTimeHere: Bool = UserDefaults.standard.value(forKey: "firstTimeHere") as? Bool ?? true
    @State var currentTibby: Tibby?
    @State var enteredApp: Bool = true

    var body: some View {
        NavigationStack {
            if networkMonitor.isConnected {
                // If connected, proceed to onboarding or home
                if canProceed {
                    if firstTimeHere {
                        OnboardingTab(firstTime: $firstTimeHere, currentTibby: $currentTibby)
                    } else {
                        if let tibby = self.currentTibby {
                            StartView(currentTibby: tibby)
                                .onAppear {
                                    if enteredApp {
                                        enteredApp = false
                                        AudioManager.instance.playMusic(audio: .happy)
                                    }
                                }
                        }
                    }
                } else {
                    SplashAnimation()
                        .onAppear {
                            if !firstTimeHere {
                                healthManager.fetchAllInformation()
                            }
                            service.setupData()
                            self.currentTibby = service.getCurrentTibby()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.8) {
                                canProceed = true
                            }
                        }
                }
            } else {
                // If no connection, show ConnectionView with a retry action
                ConnectionView(retryAction: retryAction)
            }
        }
    }

    // Retry action to check for connection and proceed
    func retryAction() {
        if networkMonitor.isConnected {
            // If internet is back, proceed
            canProceed = true
        } else {
            // You can add additional retry failure logic here (e.g., show a message)
            print("Retry failed, still no internet connection.")
        }
    }
}
