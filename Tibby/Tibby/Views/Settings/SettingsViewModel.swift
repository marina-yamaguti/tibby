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
    @Published var settingsSections: [SettingsSections] = [.haptics, .sound, .health]
    @Published var redeemCode: String = ""
    @Published var showRedeemSuccess: Bool = false
    @Published var showTestRedeem: Bool = false
    @Published var invalidAlert = false
    @Published var codeAlreadyRedeemedAlert = false

    private let testingCode = "Tibby06"
    private let validCode = "1MoreThing"
    private let codeRedeemedKey = "codeRedeemed"

    func isValidCode() -> Bool {
        return redeemCode == validCode || redeemCode == testingCode
    }

    func hasAlreadyRedeemed() -> Bool {
        return UserDefaults.standard.bool(forKey: codeRedeemedKey)
    }

    func redeemCodeAction(service: Service) {
        showRedeemSuccess = false
        invalidAlert = false
        codeAlreadyRedeemedAlert = false

        if !isValidCode() {
            invalidAlert = true
        } else if hasAlreadyRedeemed() {
            codeAlreadyRedeemedAlert = true
        } else {
            guard let user = service.getUser() else { return }
            user.coins += 100
            user.gems += 20
            
            let prizeHatID = UUID()
            service.createAccessory(
                id: prizeHatID,
                name: "Prize Hat",
                image: "PrizeHat",
                price: 10,
                category: "Head"
            )

            UserDefaults.standard.set(true, forKey: codeRedeemedKey)
            
            showRedeemSuccess = true
        }

        redeemCode = ""
    }
}
