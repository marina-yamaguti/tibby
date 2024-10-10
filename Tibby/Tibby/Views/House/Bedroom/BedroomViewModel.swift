//
//  BedroomViewModel.swift
//  Tibby
//
//  Created by Sofia Sartori on 13/08/24.
//

import Foundation

class BedroomViewModel: ObservableObject {
    let constants: Constants
    let service: Service
    var timerSleep: Timer?
    
    init(constants: Constants, service: Service) {
        self.constants = constants
        self.service = service
    }
    
    func lightsOff(tibby: Tibby) {
        constants.tibbySleeping.toggle()
        timerSleep?.invalidate()
        if constants.tibbySleeping {
            AudioManager.instance.playMusic(audio: .casual)
            self.sleepTimer(tibby: tibby)
        }
        else {
            AudioManager.instance.playMusic(audio: .happy)
        }
    }
    
    func sleepTimer(tibby: Tibby) {
        if let activity = service.getActivityByName(name: "Sleep") {
            timerSleep = Timer.scheduledTimer(withTimeInterval: 1, repeats: tibby.sleep < 100, block: { _ in
                if tibby.sleep < 100 {
                    let interaction = self.service.createInteraction(id: UUID(), tibbyId: tibby.id, activityId: activity.id, timestamp: Date())
                    self.service.applyInteractionToTibby(interaction: interaction, tibby: tibby)
                    if !self.constants.tibbySleeping {
                        self.timerSleep?.invalidate()
                        var missionsDaily = self.constants.dailyMission.getMissions()

                        for i in 0 ..< missionsDaily.count {
                            if missionsDaily[i].missionType == .sleep {
                                print(missionsDaily[i].valueDone)
                                if missionsDaily[i].valueDone < missionsDaily[i].valueTotal {
                                    missionsDaily[i].updateProgress(value: Int((self.timerSleep!.timeInterval)/60))
                                }
                                print(missionsDaily[i].valueDone)
                            }
                        }
                        self.constants.dailyMission.missions = missionsDaily
                        
                        var missionsWeekly = self.constants.weeklyMission.getMissions()

                        for i in 0 ..< missionsWeekly.count {
                            if missionsWeekly[i].missionType == .sleep {
                                print(missionsWeekly[i].valueDone)
                                if missionsWeekly[i].valueDone < missionsWeekly[i].valueTotal {
                                    missionsWeekly[i].updateProgress(value: Int((self.timerSleep!.timeInterval)/60))
                                }
                                print(missionsWeekly[i].valueDone)
                            }
                        }
                        self.constants.weeklyMission.missions = missionsWeekly
                    }
                }
                else {
                    self.timerSleep?.invalidate()
                    var missionsDaily = self.constants.dailyMission.getMissions()

                    for i in 0 ..< missionsDaily.count {
                        if missionsDaily[i].missionType == .sleep {
                            print(missionsDaily[i].valueDone)
                            if missionsDaily[i].valueDone < missionsDaily[i].valueTotal {
                                missionsDaily[i].updateProgress(value: Int((self.timerSleep!.timeInterval)/60))
                            }
                            print(missionsDaily[i].valueDone)
                        }
                    }
                    self.constants.dailyMission.missions = missionsDaily
                    
                    var missionsWeekly = self.constants.weeklyMission.getMissions()

                    for i in 0 ..< missionsWeekly.count {
                        if missionsWeekly[i].missionType == .sleep {
                            print(missionsWeekly[i].valueDone)
                            if missionsWeekly[i].valueDone < missionsWeekly[i].valueTotal {
                                missionsWeekly[i].updateProgress(value: Int((self.timerSleep!.timeInterval)/60))
                            }
                            print(missionsWeekly[i].valueDone)
                        }
                    }
                    self.constants.weeklyMission.missions = missionsWeekly
                }
                print(tibby.sleep)
            })
        }
    }
}
