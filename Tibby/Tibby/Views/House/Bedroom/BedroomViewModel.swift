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
    init(constants: Constants, service: Service) {
        self.constants = constants
        self.service = service
    }
    func lightsOff(tibby: Tibby) {
        constants.tibbySleeping.toggle()
        if let activity = service.getActivityByName(name: "Sleep") {
            let interaction = service.createInteraction(id: UUID(), tibbyId: tibby.id, activityId: activity.id, timestamp: Date())
            service.applyInteractionToTibby(interaction: interaction, tibby: tibby)
            print(tibby.sleep)
        }
        
    }
}
