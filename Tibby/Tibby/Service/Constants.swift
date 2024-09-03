//
//  Constants.swift
//  Tibby
//
//  Created by Felipe Elsner Silva on 08/07/24.
//

import Foundation
import AVFAudio
import SwiftUI

// MARK: - Singleton

/// `Constants` is a singleton class that provides shared settings and utilities for the Tibby app.
/// It manages various app settings, including Tibby's levels, room states, haptic feedback, and audio management.
class Constants: ObservableObject {
    
    /// The shared singleton instance of the `Constants` class.
    static let singleton: Constants = Constants()
    
    // MARK: - Tibby's Level Variables
    
    /// The maximum XP level Tibby can reach.
    /// A value of `-1` implies there is no maximum level.
    let maxLevel = -1
    
    /// A constant that defines the XP required to level up by multiplying it with the current level.
    let xpPerLevel = 20
    
    // MARK: - Rooms Variables
    
    /// A published property that defines whether Tibby is sleeping.
    /// It also controls the state of the room lights.
    @Published var tibbySleeping = false
    
    /// The brightness of the room, which changes based on Tibby's sleeping status.
    var brightness: Double {
        if tibbySleeping {
            return -0.5
        } else {
            return 0
        }
    }
    
    // MARK: - Haptics Variable
    
    /// A published property that controls whether haptic feedback is enabled.
    /// The value is stored in `UserDefaults`.
    @Published var vibration: Bool = UserDefaults.standard.value(forKey: "vibration") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(vibration, forKey: "vibration")
        }
    }
    
    // MARK: - Audio Manager
    
    /// A published property for managing the audio player instance.
    @Published var audioPlayer: AVAudioPlayer?
    @Published var sfxPlayer: AVAudioPlayer?
    
    /// A published property that controls whether background music is enabled.
    /// The value is stored in `UserDefaults`.
    /// When set to `true`, the background music is played; otherwise, it is stopped.
    @Published var music: Bool = UserDefaults.standard.value(forKey: "music") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(music, forKey: "music")
            if music {
                playMusic(audio: "TibbyHappyTheme")
            }
            else {
                audioPlayer?.stop()
            }
        }
    }
    
    /// A published property that controls whether sound effects is enabled.
    /// The value is stored in `UserDefaults`.
    /// When set to `true`, the background music is played; otherwise, it is stopped.
    @Published var sfx: Bool = UserDefaults.standard.value(forKey: "sfx") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(sfx, forKey: "sfx")
        }
    }
    
    func playMusic(audio: String) {
        audioPlayer?.stop() // Stop any currently playing audio
        
        if let audioURL = Bundle.main.url(forResource: audio, withExtension: "wav") {
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: audioURL)
                audioPlayer?.numberOfLoops = Int.max
                audioPlayer?.play()
            } catch {
                print("Couldn't play audio. Error: \(error)")
            }
        } else {
            print("No audio file found")
        }
    }
    
    func playSFX(audio: String) {
        sfxPlayer?.stop() // Stop any currently playing audio
        
        if let audioURL = Bundle.main.url(forResource: audio, withExtension: "wav") {
            do {
                try sfxPlayer = AVAudioPlayer(contentsOf: audioURL)
                sfxPlayer?.play()
            } catch {
                print("Couldn't play audio. Error: \(error)")
            }
        } else {
            print("No audio file found")
        }
    }
    
    
    // MARK: - Environment Variables
    
    /// A published property that defines the current environment where the user is located.
    @Published var currentEnviroment: Enviroment = .kitchen
    @Published var currentOnboarding: OnboardingViews = .onboarding1
    
    // MARK: - Tibby Status Timers
    
    /// Decreases Tibby's status values based on the time interval passed since the app was last active.
    ///
    /// - Parameters:
    ///   - tibby: The instance of `Tibby` whose status values will be decreased.
    ///   - timeInterval: The time interval to account for, typically the duration the app was in the background.
    ///   - statusList: A list of `TibbyStatus` items that should be decreased.
    ///   - closure: A closure that will be executed after the status values have been decreased.
    func decreseTibby(tibby: Tibby, timeInterval: Double, statusList: [TibbyStatus], closure: () -> Void) {
        for statusT in statusList {
            switch statusT {
            case .hungry:
                tibby.hunger -= Int(timeInterval / TibbyStatus.hungry.timeDecrease())
                tibby.hunger = max(tibby.hunger, 0)
            case .sleep:
                tibby.sleep -= Int(timeInterval / TibbyStatus.sleep.timeDecrease())
                tibby.sleep = max(tibby.sleep, 0)
            case .happy:
                tibby.happiness -= Int(timeInterval / TibbyStatus.happy.timeDecrease())
                tibby.happiness = max(tibby.happiness, 0)
            }
        }
        closure()
    }
    
    /// Creates timers for each status item and decreases the corresponding values over time.
    ///
    /// - Parameters:
    ///   - tibby: The instance of `Tibby` whose status values will be monitored and decreased.
    ///   - statusList: A list of `TibbyStatus` items to create timers for.
    ///   - closure: A closure that will be executed after each decrease.
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
    
    ///Compare two rarities and sends wich is first
    func sortRarity(rarity1: String, rarity2: String) -> Bool{
        if rarity1.lowercased() == "common" {
            return true
        }
        else if rarity1.lowercased() == "rare" && (rarity2.lowercased() == "epic" || rarity2.lowercased() == "rare") {
            return true
        }
        else if rarity1.lowercased() == "epic" && rarity2.lowercased() == "epic" {
            return true
        }
        return false
    }
}
