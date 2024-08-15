//
//  Constants.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 08/07/24.
//

import Foundation
import AVFAudio

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
    // Haptics variable
    @Published var vibration: Bool = UserDefaults.standard.value(forKey: "vibration") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(vibration, forKey: "vibration")
        }
    }
    
    //Audio manager
    @Published var audioPlayer: AVAudioPlayer?
    @Published var music: Bool = UserDefaults.standard.value(forKey: "music") as? Bool ?? true {
            didSet {
                UserDefaults.standard.set(music, forKey: "music")
                if music {
                    playAudio(audio: "TibbyHappyTheme")
                }
                else {
                    audioPlayer?.stop()
                }
            }
        }
        
    func playAudio(audio: String) {
            if let audioURL = Bundle.main.url(forResource: audio, withExtension: "wav") {
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: audioURL) /// make the audio player
                    audioPlayer?.play() /// start playing
                    audioPlayer?.numberOfLoops = Int.max
                    
                } catch {
                    print("Couldn't play audio. Error: \(error)")
                }
                
            } else {
                print("No audio file found")
            }
        }
    
    ///defines where the user is
    @Published var currentEnviroment: Enviroment = .kitchen
    @Published var currentOnboarding: OnboardingViews = .onboarding1    
    
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
