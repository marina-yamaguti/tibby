//
//  Streak.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/09/24.
//

import Foundation
import Foundation

/// A class that manages the streak functionality.
class GameStreak: ObservableObject {
    
    // MARK: - Properties
    
    /// The current streak count, representing the number of consecutive days/missions completed.
    @Published var currentStreak: Int
    
    /// The highest streak count ever achieved.
    @Published var highestStreak: Int
    
    /// The date when the streak was last updated.
    @Published var lastUpdated: Date?
    
    /// Dictionary that keeps track of the streak record for each day.
    /// The key is the date (as a string in "yyyy-MM-dd" format) and the value is `true` if the streak was active on that day, `false` otherwise.
    @Published var streakRecord: [String: Bool]
    
    // UserDefaults keys for saving streak data
    private let streakCurrentKey = "currentStreak"
    private let streakHighestKey = "highestStreak"
    private let streakLastUpdatedKey = "lastStreakUpdate"
    private let streakRecordKey = "streakRecord"
    
    /// Time interval for the streak to be considered continued. Defaults to 24 hours.
    private let streakInterval: TimeInterval = 60 * 60 * 24 // 24 hours
    
    // MARK: - Initialization
    
    /// Initializes a new `GameStreak` instance, loading the current and highest streak, as well as the last updated date and streak record from `UserDefaults`.
    init() {
        let defaults = UserDefaults.standard
        self.currentStreak = defaults.integer(forKey: streakCurrentKey)
        self.highestStreak = defaults.integer(forKey: streakHighestKey)
        self.lastUpdated = defaults.object(forKey: streakLastUpdatedKey) as? Date
        self.streakRecord = defaults.dictionary(forKey: streakRecordKey) as? [String: Bool] ?? [:]
    }
    
    // MARK: - Streak Logic
    
    /// Increments the current streak if it hasn't been updated today. If more than 24 hours have passed since the last update, the streak is reset.
    func incrementStreak() {
        let now = Date()
        let calendar = Calendar.current
        let todayString = dateToString(now)
        
        if let lastDate = lastUpdated {
            if calendar.isDateInToday(lastDate) {
                // Streak was already updated today, do nothing
                return
            } else if calendar.isDateInYesterday(lastDate) {
                // Continue the streak, as last update was yesterday
                currentStreak += 1
            } else {
                // Missed more than one day, so reset the streak
                resetStreak()
            }
        } else {
            // First streak day
            currentStreak = 1
        }
        
        // Mark today as a streak-on day
        streakRecord[todayString] = true
        lastUpdated = now
        
        // Update the highest streak if necessary
        if currentStreak > highestStreak {
            highestStreak = currentStreak
        }
        
        // Save the streak data
        saveStreak()
    }
    
    /// Resets the current streak to 0 and updates the last updated date. The updated state and daily streak record are saved to `UserDefaults`.
    func resetStreak() {
        currentStreak = 0
        lastUpdated = Date()
        saveStreak()
    }
    
    /// Saves the current streak, highest streak, last updated date, and the streak record to `UserDefaults`.
    func saveStreak() {
        let defaults = UserDefaults.standard
        defaults.set(currentStreak, forKey: streakCurrentKey)
        defaults.set(highestStreak, forKey: streakHighestKey)
        defaults.set(lastUpdated, forKey: streakLastUpdatedKey)
        defaults.set(streakRecord, forKey: streakRecordKey)
    }
    
    // MARK: - Helper Methods
    
    /// Helper method to convert a `Date` to a string in "yyyy-MM-dd" format.
    ///
    /// - Parameter date: The date to convert.
    /// - Returns: A string representing the date in "yyyy-MM-dd" format.
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
