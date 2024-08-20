//
//  Configurations.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 17/07/24.
//

import Foundation
import UIKit
import SwiftUI

/// A singleton class responsible for managing haptic feedback in the application.
class HapticManager {
    /// The shared instance of `HapticManager` for centralized access to haptic feedback functionality.
    static let instance = HapticManager()
    
    private init() {} // Private initializer to enforce singleton pattern
    
    /// Generates a haptic feedback for a notification event.
    ///
    /// - Parameter type: The type of notification feedback. The available types are `.success`, `.warning`, and `.error`.
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    /// Generates a haptic feedback for an impact event.
    ///
    /// - Parameter style: The style of impact feedback. The available styles are `.light`, `.medium`, `.heavy`, `.soft`, and `.rigid`.
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
