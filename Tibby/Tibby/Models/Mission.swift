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
enum MissionProgress {
    case progress, claim, done
}

/// Represents different types of missions that can be assigned.
///
/// - workout: A mission related to physical exercise.
/// - feed: A mission related to feeding.
/// - sleep: A mission related to sleep.
/// - steps: A mission related to taking steps.
enum MissionType {
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
}

/// A protocol defining the required properties and methods for a mission.
protocol MissionProtocol {
    /// A description of the mission.
    var description: String { get }
    
    /// The total value or goal of the mission.
    var valueTotal: Int { get set }
    
    /// The value or progress that has been completed so far.
    var valueDone: Int { get set }
    
    /// The reward given upon completion of the mission.
    var reward: Reward { get }
    
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
    func claimReward(user: User?, tibby: Tibby?)
    
    /// Updates the progress of the mission.
    ///
    /// - Parameter value: The new value to update the progress by.
    func updateProgress(value: Int)
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
    func setTimeRemaning()
    
    /// Creates the missions included in the collection.
    func createMissions()
}

struct WeekMissions: MissionsCollectionProtocol {
    var frequencyTime: DateType = .week
    
    var title: String = ""
    
    var missions: [MissionProtocol] = []
    
    var timeRemaning: (timeValue: Int, timeMesure: TimeMesure)
    
    func setTimeRemaning() {
        //
    }
    
    func createMissions() {
        //
    }
    
    
}

struct DayMissions: MissionsCollectionProtocol {
    var frequencyTime: DateType = .day
    
    var title: String = ""
    
    var missions: [MissionProtocol] = []
    
    var timeRemaning: (timeValue: Int, timeMesure: TimeMesure)
    
    func setTimeRemaning() {
        //
    }
    
    func createMissions() {
        //
    }
    
    
}
