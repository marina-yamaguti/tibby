//
//  MissionEntity.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 18/09/24.
//

import Foundation
import SwiftData

@Model
final class Mission {
    var id: UUID
    
    var name: String
    
    var valueTotal: Int
    
    var rewardValue: Int
    var rewardType: Int
    
    var xpValue: Int
    var xpType: Int
    
    var missionType: String
    
    var valueDone: Int
    
    var frequencyTime: String
    
    var progress: String
    
    init(id: UUID, name: String, valueTotal: Int, rewardValue: Int, rewardType: Int, xpValue: Int, xpType: Int, missionType: String, valueDone: Int, frequencyTime: String, progress: String) {
        self.id = id
        self.name = name
        self.valueTotal = valueTotal
        self.rewardValue = rewardValue
        self.rewardType = rewardType
        self.xpValue = xpValue
        self.xpType = xpType
        self.missionType = missionType
        self.valueDone = valueDone
        self.frequencyTime = frequencyTime
        self.progress = progress
    }
}
