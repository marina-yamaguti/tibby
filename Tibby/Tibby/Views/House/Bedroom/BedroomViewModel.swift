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
                    }
                }
                else {
                    self.timerSleep?.invalidate()
                }
                print(tibby.sleep)
            })
        }
    }
}
