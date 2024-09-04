//
//  NotificationManager.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import Foundation
import UserNotifications

/// A class responsible for managing notification permissions for the application.
class NotificationManager {
    
    /// Requests permission from the user to display notifications.
    ///
    /// - Parameter completion: A closure that takes a `Bool` as its parameter. The closure is executed
    ///                         after the permission request is completed. The `Bool` indicates whether
    ///                         the permission was granted (`true`) or denied (`false`).
    ///
    /// - Note: If an error occurs during the request, the `completion` closure will be called with `false`.
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permissions: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(granted)
        }
    }
}
