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

/// Represents different types of missions that can be assigned.
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
    
    func missionValue(difficulty: Int) -> Int {
        switch self {
        case .workout:
            switch difficulty {
            case 1:
                return 5
                
            case 2:
                return 15
                
            case 5:
                return 20
                
            case 6:
                return 35
                
            default:
                return 0
            }
        case .feed:
            switch difficulty {
            case 1:
                return 5
                
            case 2:
                return 15
                
            case 5:
                return 20
                
            case 6:
                return 35
                
            default:
                return 0
            }
        case .sleep:
            switch difficulty {
            case 1:
                return 5
                
            case 2:
                return 15
                
            case 5:
                return 20
                
            case 6:
                return 35
                
            default:
                return 0
            }
        case .steps:
            switch difficulty {
            case 1:
                return 5
                
            case 2:
                return 15
                
            case 5:
                return 20
                
            case 6:
                return 35
                
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
    var xp: Reward { get }
    
    /// The frequency or timing for the mission.
    var frequencyTime: DateType { get }
    
    /// The current progress status of the mission.
    var progress: MissionProgress { get set }
    
    /// The type of mission.
    var missionType: MissionType { get }
    
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
    
    /// The remaining time for the collection of missions.
    var timeRemaning: (timeValue: Int, timeMesure: TimeMesure) { get set }
    
    /// Sets the remaining time for the missions in the collection.
    mutating func setTimeRemaning()
    
    /// Creates the missions included in the collection.
    mutating func createMissions()
    
    /// Return the missions in the correct order to show in screen
    func getMissions() -> [MissionProtocol]
}

struct WeekMissionsCollection: MissionsCollectionProtocol {
    var frequencyTime: DateType = .week
    
    var title: String = ""
    
    var missions: [MissionProtocol] = []
    
    var timeRemaning: (timeValue: Int, timeMesure: TimeMesure) = (timeValue: Calendar.current.component(.day, from: Date.startOfWeek), timeMesure: .day)
    
    var missionManager = MissionManager()
    
    mutating func setTimeRemaning() {
        if timeRemaning.timeValue != 1 && timeRemaning.timeMesure == .day {
            timeRemaning = (timeValue: Calendar.current.component(.day, from: Date.startOfWeek), timeMesure: .day)
        }
        else {
            timeRemaning = (timeValue: Calendar.current.component(.hour, from: Date.startOfWeek), timeMesure: .hour)
        }
    }
    
    mutating func createMissions() {
        for mt in MissionType.allCases {
            missions.append(missionManager.createMission(dateType: frequencyTime, missionType: mt))
        }
    }
    
    func getMissions() -> [any MissionProtocol] {
        return missions.sorted { mission1, mission2 in
            mission1.progress < mission2.progress
        }
    }
}

struct DayMissionsCollection: MissionsCollectionProtocol {
    var frequencyTime: DateType = .day
    
    var title: String = ""
    
    var missions: [MissionProtocol] = []
    
    var timeRemaning: (timeValue: Int, timeMesure: TimeMesure) = (timeValue: Calendar.current.component(.hour, from: Date.startOfDay), timeMesure: .hour)
    
    var missionManager = MissionManager()
    
    mutating func setTimeRemaning() {
        timeRemaning = (timeValue: Calendar.current.component(.hour, from: Date.startOfDay), timeMesure: .hour)
    }
    
    mutating func createMissions() {
        for mt in MissionType.allCases {
            missions.append(missionManager.createMission(dateType: frequencyTime, missionType: mt))
        }
    }
    
    func getMissions() -> [any MissionProtocol] {
        return missions.sorted { mission1, mission2 in
            mission1.progress < mission2.progress
        }
    }
}

struct MissionDay: MissionProtocol {
    var description: String
    
    var valueTotal: Int
    
    var reward: Reward
    
    var xp: Reward
    
    var missionType: MissionType
    
    var valueDone: Int = 0
    
    var frequencyTime: DateType = .day
    
    var progress: MissionProgress = .inProgress
    
    mutating func claimReward(user: User?, tibby: Tibby?) {
        if progress == .claim {
            progress = .done
            reward.reward(user: user)
            xp.reward(tibby: tibby)
        }
    }
    
    mutating func updateProgress(value: Int) {
        valueDone += value
        if valueDone >= valueTotal {
            progress = .claim
        }
    }
}

struct MissionWeek: MissionProtocol {
    var description: String
    
    var valueTotal: Int
    
    var reward: Reward
    var xp: Reward
    
    var missionType: MissionType
    
    var valueDone: Int = 0
    
    var frequencyTime: DateType = .week
    
    var progress: MissionProgress = .inProgress
    
    mutating func claimReward(user: User?, tibby: Tibby?) {
        if progress == .claim {
            progress = .done
            reward.reward(user: user)
            xp.reward(tibby: tibby)
        }
    }
    
    mutating func updateProgress(value: Int) {
        valueDone += value
        if valueDone >= valueTotal {
            progress = .claim
        }
    }
}
