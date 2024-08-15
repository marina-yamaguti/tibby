//
//  SettingsViewModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import Foundation
import UIKit

enum SettingsSections: Hashable {
    case notifications, haptics, sound, health
    
    var title: String {
        switch self {
        case .notifications: return "App Notifications"
        case .haptics: return "Haptics"
        case .sound: return "Sound"
        case .health: return "Health Information"
        }
    }
    var labels: [String] {
        switch self {
        case .notifications: return ["Notifications"]
        case .haptics: return ["Haptics"]
            // TODO: add sound effects when ready
        case .sound: return ["Music"]
        case .health: return ["Health"]
        }
    }
    var trailingType: TrailingType {
        switch self {
        case .notifications: return .details
        case .haptics: return .toggleButton
        case .sound: return .toggleButton
        case .health: return .details
        }
    }
}

class SettingsViewModel: ObservableObject {
    @Published var settingsSections: [SettingsSections] = [.notifications, .haptics, .sound, .health]
    @Published var notificationIsEnabled: Bool = false
    
    func openAppSettings() {
        if let appSettingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(appSettingsURL) {
                UIApplication.shared.open(appSettingsURL, options: [:], completionHandler: nil)
            }
        }
    }
}
    
