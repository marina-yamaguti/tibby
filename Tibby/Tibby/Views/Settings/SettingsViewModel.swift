//
//  SettingsViewModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import Foundation
import UIKit
import SwiftUI


enum SettingsSections: Hashable {
//    case notifications, haptics, sound, health
    case haptics, sound, health

    
    var title: String {
        switch self {
       // case .code: return "Code Redeem"
      //  case .notifications: return "App Notifications"
        case .haptics: return "Haptics Feedback"
        case .sound: return "Game Sounds"
        case .health: return "Health Information"
        }
    }
    var labels: [String] {
        switch self {
        
      //  case .notifications: return ["Notifications"]
        case .haptics: return ["Phone Vibrations"]
        case .sound: return ["Sound Effects", "Music"]
        case .health: return ["Health"]
        }
    }
    var trailingType: TrailingType {
        switch self {
       // case .notifications: return .details
        case .haptics: return .toggleButton
        case .sound: return .toggleButton
        case .health: return .details
        }
    }
    var color: Color {
        switch self {
       // case .notifications: .tibbyBaseRed
        case .haptics: .tibbyBaseGreen
        case .sound: .tibbyBaseBlue
        case .health: .tibbyBasePink
        }
        
    }
}

class SettingsViewModel: ObservableObject {
//    @Published var settingsSections: [SettingsSections] = [.notifications, .haptics, .sound, .health]
    @Published var settingsSections: [SettingsSections] = [.haptics, .sound, .health]
    @Published var notificationIsEnabled: Bool = false
    @Published var redeemCode: String = ""
    @Published var coins: Int = 0
    @Published var showRedeemSuccess: Bool = false
    @Published var invalidAlert = false

   // @EnvironmentObject var service: Service

    private let validCode = "Tibby06"
    //@ObservedObject var moneyViewModel = MoneyViewModel()
    
//    init(moneyViewModel: MoneyViewModel) {
//            self.moneyViewModel = moneyViewModel
//        }
//    
    func isValidCode() -> Bool {
            return redeemCode == validCode
        }
    
    func redeemCodeAction(service: Service) {
            if isValidCode() {
                guard let user = service.getUser() else { return }
                user.coins += 1000
                showRedeemSuccess = true
            } else {
                invalidAlert = true
            }
            redeemCode = "" // Limpa o campo de código após o sucesso
        }
    
    func openAppSettings() {
        if let appSettingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(appSettingsURL) {
                UIApplication.shared.open(appSettingsURL, options: [:], completionHandler: nil)
            }
        }
    }
}

