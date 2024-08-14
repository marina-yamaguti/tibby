//
//  SettingsViewModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import Foundation

enum SettingsSections: Hashable {
    case notifications, haptics, sound, health
    
    var title: String {
        switch self {
        case .notifications: return "Notifications"
        case .haptics: return "Haptics"
        case .sound: return "Sound"
        case .health: return "Health Information"
        }
    }
    var labels: [String] {
        switch self {
        case .notifications: return ["Enable Notifications"]
        case .haptics: return ["Enable Haptics"]
        case .sound: return ["Enable Sound Effects", "Enable Music"]
        case .health: return ["Enable Health"]
        }
    }
    var trailingType: TrailingType {
        switch self {
        case .notifications: return .toggleButton
        case .haptics: return .toggleButton
        case .sound: return .toggleButton
        case .health: return .details
        }
    }
}

struct SettingsViewModel {
    
}
