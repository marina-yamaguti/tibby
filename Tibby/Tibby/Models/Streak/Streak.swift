//
//  Streak.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/09/24.
//

import Foundation

/// A struct that manages the streak functionality.
struct GameStreak {
    
    // MARK: - Properties
    
    /// The current streak count, representing the number of consecutive days/missions completed.
    var currentStreak: Int
    
    /// The highest streak count ever achieved.
    var highestStreak: Int
    
    /// The date when the streak was last updated.
    var lastUpdated: Date?
    
    // UserDefaults keys for saving streak data
    private let streakCurrentKey = "currentStreak"
    private let streakHighestKey = "highestStreak"
    private let streakLastUpdatedKey = "lastStreakUpdate"
    
    /// Time interval for the streak to be considered continued. Defaults to 24 hours.
    private let streakInterval: TimeInterval = 60 * 60 * 24 // 24 hours
    
    // MARK: - Initialization
    
    /// Initializes a new `GameStreak` instance, loading the current and highest streak, as well as the last updated date from `UserDefaults`.
    init() {
        let defaults = UserDefaults.standard
        self.currentStreak = defaults.integer(forKey: streakCurrentKey)
        self.highestStreak = defaults.integer(forKey: streakHighestKey)
        self.lastUpdated = defaults.object(forKey: streakLastUpdatedKey) as? Date
    }
    
    // MARK: - Streak Logic
    
    /// Increments the current streak if it hasn't been updated today. If more than 24 hours have passed since the last update, the streak is reset. The updated streak is saved to `UserDefaults`.
    mutating func incrementStreak() {
        let now = Date()
        let calendar = Calendar.current
        
        if let lastDate = lastUpdated {
            // If the streak was updated today, do nothing
            if calendar.isDateInToday(lastDate) {
                return
            }
            // If more than 24 hours have passed, reset the streak
            if now.timeIntervalSince(lastDate) > streakInterval {
                resetStreak()
            }
        }
        
        currentStreak += 1
        lastUpdated = now
        
        if currentStreak > highestStreak {
            highestStreak = currentStreak
        }
        
        saveStreak()
    }
    
    /// Resets the current streak to 0 and updates the last updated date. The updated state is saved to `UserDefaults`.
    mutating func resetStreak() {
        currentStreak = 0
        lastUpdated = Date()
        saveStreak()
    }
    
    /// Checks if more than 24 hours have passed since the last streak update. If so, the streak is reset.
    mutating func checkStreakStatus() {
        if let lastDate = lastUpdated, Date().timeIntervalSince(lastDate) > streakInterval {
            resetStreak()
        }
    }
    
    /// Returns the time remaining in seconds before the streak resets. Returns `nil` if no streak is in progress.
    ///
    /// - Returns: Time interval in seconds before the streak resets, or `nil` if no streak has started.
    func timeRemainingForNextUpdate() -> TimeInterval? {
        guard let lastDate = lastUpdated else {
            return nil
        }
        let nextReset = lastDate.addingTimeInterval(streakInterval)
        return max(0, nextReset.timeIntervalSinceNow)
    }
    
    // MARK: - UserDefaults Management
    
    /// Saves the current streak, highest streak, and last updated date to `UserDefaults`.
    private func saveStreak() {
        let defaults = UserDefaults.standard
        defaults.set(currentStreak, forKey: streakCurrentKey)
        defaults.set(highestStreak, forKey: streakHighestKey)
        defaults.set(lastUpdated, forKey: streakLastUpdatedKey)
    }
}
