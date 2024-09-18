//
//  MissionsViewModel.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 18/09/24.
//

import Foundation
import SwiftUI

class MissionsViewModel: ObservableObject {
    @Published var dailyMission: DayMissionsCollection = UserDefaults.standard.value(forKey: "DayMissions") as? DayMissionsCollection ?? DayMissionsCollection(dateSet: Date.startOfDay)
    @Published var weeklyMission: WeekMissionsCollection = UserDefaults.standard.value(forKey: "WeekMissions") as? WeekMissionsCollection ?? WeekMissionsCollection(dateSet: Date.startOfWeek)
    let missionManager = MissionManager.instance
    
    func generateMissions() {
        dailyMission.missions = MissionType.allCases.map {
            missionManager.createMission(dateType: .day, missionType: $0)
        }

        weeklyMission.missions = MissionType.allCases.map {
            missionManager.createMission(dateType: .week, missionType: $0)
        }
    }
}
