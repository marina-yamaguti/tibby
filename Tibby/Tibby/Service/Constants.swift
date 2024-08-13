//
//  Constants.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 08/07/24.
//

import Foundation

//MARK: Singleton
class Constants: ObservableObject {
    static let singleton: Constants = Constants()
    
    //tibby's level variables
    ///defines the max XP level that the tibby could reach
    let maxLevel = -1
    ///defines a constants that, multiplied by the level, defines the XP quantity to level up
    let xpPerLevel = 20
    
    //rooms variables
    ///defines if the tibby is sleeping or not and if the lights will be on or off
    @Published var tibbySleeping = false
    var brightness: Double {
        if tibbySleeping {
            return -0.5
        }
        else {
            return 0
        }
    }
    ///defines where the user is
    @Published var currentEnviroment: Enviroment = .kitchen
    @Published var currentOnboarding: OnboardingScreens = .onboarding1
    @Published var onboardingVisited: [Bool] = [true, false, false, false]
    
    
    ///defines the timers of the pet
    func decreseTibby(tibby: Tibby, timeInterval: Double, statusList: [TibbyStatus], closure: () -> Void) {
        //subtract when user has the app in background
        for statusT in statusList {
            switch statusT {
            case .hungry:
                tibby.hunger -= Int(timeInterval/TibbyStatus.hungry.timeDecrease())
                if tibby.hunger <= 0 {
                    tibby.hunger = 0
                }
            case .sleep:
                tibby.sleep -= Int(timeInterval/TibbyStatus.sleep.timeDecrease())
                if tibby.sleep <= 0 {
                    tibby.sleep = 0
                }
            case .happy:
                tibby.happiness -= Int(timeInterval/TibbyStatus.happy.timeDecrease())
                if tibby.happiness <= 0 {
                    tibby.happiness = 0
                }
            }
        }
        closure()
    }
    
    func createTimer(tibby: Tibby, statusList: [TibbyStatus], closure: () -> Void) {
        //create the timers for each necessity item and decrease the necessity
        for statusT in statusList {
            Timer.scheduledTimer(withTimeInterval: TimeInterval(statusT.timeDecrease()), repeats: true) { _ in
                switch statusT {
                case .hungry:
                    if tibby.hunger != 0 {
                        tibby.hunger -= 1
                    }
                case .sleep:
                    if tibby.sleep != 0 {
                        tibby.sleep -= 1
                    }
                case .happy:
                    if tibby.happiness != 0 {
                        tibby.happiness -= 1
                    }
                }
            }
            closure()
        }
    }
}
