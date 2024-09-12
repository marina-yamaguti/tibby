//
//  Mission.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 29/08/24.
//

import Foundation

/// Represents the progress of a mission.
///
/// - progress: The mission is currently in progress.
/// - claim: The mission is completed and the reward can be claimed.
/// - done: The mission is fully completed and no further actions are needed.
enum MissionProgress: Comparable {
    case claim, inProgress, done
}

/// Represents the different types of missions that can be assigned to the user.
///
/// - workout: A mission related to physical exercise.
/// - feed: A mission related to feeding.
/// - sleep: A mission related to sleep.
/// - steps: A mission related to taking steps.
enum MissionType: CaseIterable {
    case workout, feed, sleep, steps
    
    /// The icon associated with each mission type.
    var icon: String {
        switch self {
        case .workout:
            return "TibbySymbolDumbbell"
        case .feed:
            return "TibbySymbolCarrot"
        case .sleep:
            return "TibbySymbolSleep"
        case .steps:
            return "TibbySymbolSteps"
        }
    }
    
    /// Provides a description of the mission based on its type, value, and frequency.
    ///
    /// - Parameters:
    ///   - value: The value associated with the mission.
    ///   - frequency: The frequency of the mission (e.g., daily, weekly).
    /// - Returns: A string description of the mission.
    func missionDescription(value: Int, frequency: DateType) -> String {
        switch self {
        case .workout:
            return "\(value) \(frequency == .day ? "minutes" : "hours") of workout"
        case .feed:
            return "feed \(value) times"
        case .sleep:
            return "\(value) \(frequency == .day ? "minutes" : "hours") of sleep"
        case .steps:
            return "\(value) steps"
        }
    }
    
    /// Calculates the mission's target value based on its type and difficulty.
    ///
    /// - Parameter difficulty: The difficulty level of the mission.
    /// - Returns: The target value for the mission.
    func missionValue(difficulty: Int) -> Int {
        switch self {
        case .workout:
            switch difficulty {
            case 1:
#warning("UserDefaults.standard.value(forKey: workout)")
                return 30
                
            case 2:
#warning("UserDefaults.standard.value(forKey: workout) * 1.5")
                return 60
                
            case 5:
#warning("Int((UserDefaults.standard.value(forKey: workout) * 5)/60)")
                return 5
                
            case 6:
#warning("Int((UserDefaults.standard.value(forKey: workout) * 7)/60)")
                return 10
                
            default:
                return 0
            }
        case .feed:
            switch difficulty {
            case 1:
                return 2
                
            case 2:
                return 3
                
            case 5:
                return 15
                
            case 6:
                return 18
                
            default:
                return 0
            }
        case .sleep:
            switch difficulty {
            case 1:
#warning("Int(UserDefaults.standard.value(forKey: sleep) * 0.8)")
                return 6
                
            case 2:
#warning("UserDefaults.standard.value(forKey: sleep)")
                return 8
                
            case 5:
#warning("UserDefaults.standard.value(forKey: sleep) * 5")
                return 15
                
            case 6:
#warning("Int((UserDefaults.standard.value(forKey: sleep) * 7)/60)")
                return 20
                
            default:
                return 0
            }
        case .steps:
            switch difficulty {
            case 1:
#warning("UserDefaults.standard.value(forKey: steps)")
                return 1000
                
            case 2:
#warning("UserDefaults.standard.value(forKey: steps) * 2")
                return 2000
                
            case 5:
#warning("UserDefaults.standard.value(forKey: steps) * 10")
                return 10000
                
            case 6:
#warning("UserDefaults.standard.value(forKey: steps) * 20")
                return 20000
                
            default:
                return 0
            }
        }
    }
}

/// A protocol defining the required properties and methods for a mission.
protocol MissionProtocol {
    /// A description of the mission.
    var description: String { get }
    
    /// The total value or goal of the mission.
    var valueTotal: Int { get }
    
    /// The value or progress that has been completed so far.
    var valueDone: Int { get set }
    
    /// The reward given upon completion of the mission.
    var reward: Reward { get }
    
    /// The experience points (XP) reward given upon completion of the mission.
    var xp: Reward { get }
    
    /// The frequency or timing for the mission.
    var frequencyTime: DateType { get }
    
    /// The current progress status of the mission.
    var progress: MissionProgress { get set }
    
    /// The type of mission.
    var missionType: MissionType { get }
    
    var id: UUID { get }
    
    /// Claims the reward for the mission.
    ///
    /// - Parameters:
    ///   - user: The user claiming the reward.
    ///   - tibby: The Tibby associated with the mission.
    mutating func claimReward(user: User?, tibby: Tibby?)
    
    /// Updates the progress of the mission.
    ///
    /// - Parameter value: The new value to update the progress by.
    mutating func updateProgress(value: Int)
}

/// A protocol defining a collection of missions.
protocol MissionsCollectionProtocol {
    /// The frequency or timing for the entire collection of missions.
    var frequencyTime: DateType { get }
    
    /// The title of the mission collection.
    var title: String { get }
    
    /// The list of missions included in the collection.
    var missions: [MissionProtocol] { get set }
    
    /// The remaining time for the collection of missions.
    var timeRemaning: (timeValue: Int, timeMesure: TimeMesure) { get set }
    
    /// Sets the remaining time for the missions in the collection.
    mutating func setTimeRemaning()
    
    /// Creates the missions included in the collection.
    mutating func createMissions()
    
    /// Returns the missions in the correct order to display on the screen.
    ///
    /// - Returns: An array of missions sorted by their progress.
    func getMissions() -> [MissionProtocol]
}

/// A structure representing a weekly collection of missions.
struct WeekMissionsCollection: MissionsCollectionProtocol {
    var frequencyTime: DateType = .week
    
    var title: String = ""
    
    var missions: [MissionProtocol] = []
    
    var timeRemaning: (timeValue: Int, timeMesure: TimeMesure) = (timeValue: Calendar.current.component(.day, from: Date.startOfWeek), timeMesure: .day)
    
    var missionManager = MissionManager()
    
    /// Sets the remaining time for the missions in the weekly collection.
    mutating func setTimeRemaning() {
        if timeRemaning.timeValue != 1 && timeRemaning.timeMesure == .day {
            timeRemaning = (timeValue: Calendar.current.component(.day, from: Date.startOfWeek), timeMesure: .day)
        }
        else {
            timeRemaning = (timeValue: Calendar.current.component(.hour, from: Date.startOfWeek), timeMesure: .hour)
        }
    }
    
    /// Creates the missions for the weekly collection.
    mutating func createMissions() {
        for mt in MissionType.allCases {
            missions.append(missionManager.createMission(dateType: frequencyTime, missionType: mt))
        }
    }
    
    /// Returns the missions in the weekly collection sorted by progress.
    ///
    /// - Returns: An array of missions sorted by their progress.
    func getMissions() -> [any MissionProtocol] {
        return missions.sorted { mission1, mission2 in
            mission1.progress < mission2.progress
        }
    }
}

/// A structure representing a daily collection of missions.
struct DayMissionsCollection: MissionsCollectionProtocol {
    var frequencyTime: DateType = .day
    
    var title: String = ""
    
    var missions: [MissionProtocol] = []
    
    var timeRemaning: (timeValue: Int, timeMesure: TimeMesure) = (timeValue: Calendar.current.component(.hour, from: Date.startOfDay), timeMesure: .hour)
    
    var missionManager = MissionManager()
    
    /// Sets the remaining time for the missions in the daily collection.
    mutating func setTimeRemaning() {
        timeRemaning = (timeValue: Calendar.current.component(.hour, from: Date.startOfDay), timeMesure: .hour)
    }
    
    /// Creates the missions for the daily collection.
    mutating func createMissions() {
        for mt in MissionType.allCases {
            missions.append(missionManager.createMission(dateType: frequencyTime, missionType: mt))
        }
    }
    
    /// Returns the missions in the daily collection sorted by progress.
    ///
    /// - Returns: An array of missions sorted by their progress.
    func getMissions() -> [any MissionProtocol] {
        return missions.sorted { mission1, mission2 in
            mission1.progress < mission2.progress
        }
    }
}

/// A structure representing a mission that is part of a daily collection.
struct MissionDay: MissionProtocol {
    var id: UUID
    
    var description: String
    
    var valueTotal: Int
    
    var reward: Reward
    
    var xp: Reward
    
    var missionType: MissionType
    
    var valueDone: Int = 0
    
    var frequencyTime: DateType = .day
    
    var progress: MissionProgress = .inProgress
    
    /// Claims the reward for the mission if it's ready to be claimed.
    ///
    /// - Parameters:
    ///   - user: The user claiming the reward.
    ///   - tibby: The Tibby associated with the mission.
    mutating func claimReward(user: User?, tibby: Tibby?) {
        if progress == .claim {
            progress = .done
            reward.reward(user: user)
            xp.reward(tibby: tibby)
        }
    }
    
    /// Updates the progress of the mission based on the value provided.
    ///
    /// - Parameter value: The amount of progress to add to the mission.
    mutating func updateProgress(value: Int) {
        valueDone += value
        if valueDone >= valueTotal {
            progress = .claim
        }
    }
}

/// A structure representing a mission that is part of a weekly collection.
struct MissionWeek: MissionProtocol {
    var id: UUID
    
    var description: String
    
    var valueTotal: Int
    
    var reward: Reward
    var xp: Reward
    
    var missionType: MissionType
    
    var valueDone: Int = 0
    
    var frequencyTime: DateType = .week
    
    var progress: MissionProgress = .inProgress
    
    /// Claims the reward for the mission if it's ready to be claimed.
    ///
    /// - Parameters:
    ///   - user: The user claiming the reward.
    ///   - tibby: The Tibby associated with the mission.
    mutating func claimReward(user: User?, tibby: Tibby?) {
        if progress == .claim {
            progress = .done
            reward.reward(user: user)
            xp.reward(tibby: tibby)
        }
    }
    /// Updates the progress of the mission based on the value provided.
    ///
    /// - Parameter value: The amount of progress to add to the mission.
    mutating func updateProgress(value: Int) {
        valueDone += value
        if valueDone >= valueTotal {
            progress = .claim
        }
    }
}
