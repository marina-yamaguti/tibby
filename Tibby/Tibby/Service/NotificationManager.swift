//
//  NotificationManager.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        // Get the current notification center
        let center = UNUserNotificationCenter.current()

        // Request authorization to show notifications
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permissions: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Call the completion handler with the result
            completion(granted)
        }
    }
}

// Example usage:
//let notificationManager = NotificationManager()
//notificationManager.requestNotificationPermission { granted in
//    if granted {
//        print("Notification permission granted")
//    } else {
//        print("Notification permission denied")
//    }
//}
