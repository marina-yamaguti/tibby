//
//  MusicManager.swift
//  Tibby
//
//  Created by Felipe Elsner Silva on 03/09/24.
//

import Foundation
import AVFAudio

/// A singleton class responsible for managing background music and sound effects in the Tibby app.
class AudioManager {
    
    /// The shared instance of `AudioManager` for centralized access to audio functionality.
    static let instance = AudioManager()
    
    /// The audio player instance used for background music.
    @Published private var audioPlayer: AVAudioPlayer?
    
    /// The audio player instance used for sound effects (SFX).
    @Published private var sfxPlayer: AVAudioPlayer?
    
    /// The audio player instance used for the secondary sound effects (SFX).
    @Published private var sfxPlayerSecondary: AVAudioPlayer?
    
    /// The audio player instance used for tibby sounds.
    @Published private var tibbySoundPlayer: AVAudioPlayer?
    
    private var currentMusic: Music = .happy
    
    /// A boolean property that controls whether background music is enabled.
    ///
    /// The value is stored in `UserDefaults`. When set to `true`, the background music is played;
    /// when set to `false`, the background music is stopped.
    @Published var music: Bool = UserDefaults.standard.value(forKey: "music") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(music, forKey: "music")
            if music {
                playMusic(audio: currentMusic)
            } else {
                audioPlayer?.stop()
            }
        }
    }
    
    /// A boolean property that controls whether sound effects (SFX) are enabled.
    ///
    /// The value is stored in `UserDefaults`. When set to `true`, sound effects are played;
    /// when set to `false`, sound effects are disabled.
    @Published var sfx: Bool = UserDefaults.standard.value(forKey: "sfx") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(sfx, forKey: "sfx")
        }
    }
    
    /// Private initializer to enforce the singleton pattern.
    private init() {
        configureAudioSession() // Configure the audio session when initializing AudioManager
    }
    
    /// Configures the audio session to allow playback even in silent mode.
    private func configureAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }
    
    /// Plays background music using the provided audio file name.
    ///
    /// - Parameter audio: The name of the audio file without extension to be played as background music.
    ///
    /// If an audio file is already playing, it will be stopped before the new one begins.
    func playMusic(audio: Music) {
        audioPlayer?.stop() // Stop any currently playing audio
        currentMusic = audio
        if music {
            if let audioURL = Bundle.main.url(forResource: audio.rawValue, withExtension: audio.soundExtension) {
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: audioURL)
                    if audio != .suspenseGachaPull {
                        audioPlayer?.numberOfLoops = Int.max
                    }
                    audioPlayer?.play()
                } catch {
                    print("Couldn't play audio. Error: \(error)")
                }
            } else {
                print("No audio file found")
            }
        } else {
            audioPlayer?.stop() // Stop any currently playing audio
        }
    }
    
    /// Plays a sound effect (SFX) using the provided audio file name.
    ///
    /// - Parameter audio: The name of the audio file without extension to be played as background music.
    ///
    /// If an SFX is already playing, it will be stopped before the new one begins.
    func playSFXSecondary(audio: SFX) {
        sfxPlayerSecondary?.stop() // Stop any currently playing audio
        if sfx {
            if let audioURL = Bundle.main.url(forResource: audio.rawValue, withExtension: audio.soundExtension) {
                do {
                    try sfxPlayerSecondary = AVAudioPlayer(contentsOf: audioURL)
                    sfxPlayerSecondary?.play()
                } catch {
                    print("Couldn't play audio. Error: \(error)")
                }
            } else {
                print("No audio file found")
            }
        } else {
            sfxPlayerSecondary?.stop() // Stop any currently playing audio
        }
    }
    
    /// Plays a sound effect (SFX) using the provided audio file name.
    ///
    /// - Parameter audio: The name of the audio file without extension to be played as background music.
    ///
    /// If an SFX is already playing, it will be stopped before the new one begins.
    func playSFX(audio: SFX) {
        sfxPlayer?.stop() // Stop any currently playing audio
        if sfx {
            if let audioURL = Bundle.main.url(forResource: audio.rawValue, withExtension: audio.soundExtension) {
                do {
                    try sfxPlayer = AVAudioPlayer(contentsOf: audioURL)
                    sfxPlayer?.play()
                } catch {
                    print("Couldn't play audio. Error: \(error)")
                }
            } else {
                print("No audio file found")
            }
        } else {
            sfxPlayer?.stop() // Stop any currently playing audio
        }
    }

#warning("QUANDO SONS DOS TIBBIES FOREM DECIDIDOS IMPLEMENTAR")
    /// Plays a tibby sound using the provided audio file name.
    ///
    /// - Parameter audio: The name of the audio file without extension to be played as background music.
    ///
    /// If an SFX is already playing, it will be stopped before the new one begins.
//    func playTibbySound(audio: TibbySound) {
//        tibbySoundPlayer?.stop() // Stop any currently playing audio
//        if sfx {
//            if let audioURL = Bundle.main.url(forResource: audio.rawValue, withExtension: audio.soundExtension) {
//                do {
//                    try tibbySoundPlayer = AVAudioPlayer(contentsOf: audioURL)
//                    tibbySoundPlayer?.play()
//                } catch {
//                    print("Couldn't play audio. Error: \(error)")
//                }
//            } else {
//                print("No audio file found")
//            }
//        } else {
//            tibbySoundPlayer?.stop() // Stop any currently playing audio
//        }
//    }
}

#warning("QUANDO SONS DOS TIBBIES FOREM DECIDIDOS IMPLEMENTAR")
    /// Plays a tibby sound using the provided audio file name.
    ///
    /// - Parameter audio: The name of the audio file without extension to be played as background music.
    ///
    /// If an SFX is already playing, it will be stopped before the new one begins.
//    func playTibbySound(audio: TibbySound) {
//        tibbySoundPlayer?.stop() // Stop any currently playing audio
//        if sfx {
//            if let audioURL = Bundle.main.url(forResource: audio.rawValue, withExtension: audio.soundExtension) {
//                do {
//                    try tibbySoundPlayer = AVAudioPlayer(contentsOf: audioURL)
//                    tibbySoundPlayer?.play()
//                } catch {
//                    print("Couldn't play audio. Error: \(error)")
//                }
//            } else {
//                print("No audio file found")
//            }
//        }
//        else {
//            tibbySoundPlayer?.stop() // Stop any currently playing audio
//        }
//    }



enum SFX: String {
    case primaryButton = "PrimaryButton"
    case secondaryButton = "SecondaryButton"
    case tertiaryButton = "TertiaryButton"
    case capsuleOpen = "CapsuleOpen"
    case coinInsert1 = "CoinInsert1"
    case coinInsert2 = "CoinInsert2"
    case commonPull = "CommonPull"
    case rarePull = "RarePull"
    case epicPull = "EpicPull"
    case gachaMachineTwist = "GachaMachineTwist"
    case streakUp = "StreakUp"
    case notification = "Notification"
    case popup = "Popup"
    
    var soundExtension: String {
        switch self {
        case .capsuleOpen, .coinInsert1, .coinInsert2, .gachaMachineTwist, .rarePull, .notification, .popup:
            "mp3"
        case .commonPull, .epicPull, .tertiaryButton, .secondaryButton, .primaryButton, .streakUp:
            "wav"
        }
    }
}

enum Music: String {
    case casual = "CasualSong"
    case intricate = "IntricateSong"
    case happy = "TibbyHappyTheme"
    case mysterious = "MysteriousSong"
    case suspenseGachaPull = "SuspenseGachaPull"
    
    var soundExtension: String {
        switch self {
        case .casual, .intricate, .happy, .mysterious:
            return "wav"
        case .suspenseGachaPull:
            return "mp3"
        }
    }
}

#warning("QUANDO SONS DOS TIBBIES FOREM DECIDIDOS IMPLEMENTAR")
//enum TibbySounds: String {
//
//}
