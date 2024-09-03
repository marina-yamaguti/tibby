//
//  TibbySelectedViewModel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import Foundation
import SwiftUI
import SwiftData

class TibbySelectedViewModel: ObservableObject {
    var service: Service
    @Binding var tibby: Tibby
    @Binding var currentTibby: Tibby
    @Published var status: SelectionStatus
    
    init(tibby: Binding<Tibby>, currentTibby: Binding<Tibby>, status: SelectionStatus, service: Service) {
        self._tibby = tibby
        self._currentTibby = currentTibby
        self.status = status
        self.service = service
    }
    
    var color: Color {
        switch tibby.collection {
        case Collection.seaSeries.rawValue:
            return Color.tibbyBaseBlue
        case Collection.houseSeries.rawValue:
            return Color.tibbyBasePink
        case Collection.forestSeries.rawValue:
            return Color.tibbyBaseGreen
        case Collection.beachSeries.rawValue:
            return Color.tibbyBaseOrange
        case Collection.foodSeries.rawValue:
            return Color.tibbyBaseRed
        case Collection.urbanSeries.rawValue:
            return Color.tibbyBaseGrey
        default:
            return Color.gray
        }
    }
    
    var species: String {
        return tibby.species
    }
    
    var rarity: Rarity {
        return Rarity(rawValue: tibby.rarity) ?? Rarity.common
    }
    
    var description: String {
        return tibby.details
    }

    
    func changeTibby(vibration: Bool) {
        currentTibby = tibby
        service.getUser()?.currentTibbyID = currentTibby.id
        status = .selected
        if vibration {
            HapticManager.instance.impact(style: .soft)
        }
    }
    
    func convertCamelCaseToSpaces(_ input: String) -> String {
        // Transforma o primeiro caractere em minúscula
        let lowercaseInput = input.prefix(1).lowercased() + input.dropFirst()
        
        // Substitui as letras maiúsculas por um espaço seguido da letra minúscula correspondente
        let spacedString = lowercaseInput.reduce("") { result, character in
            if character.isUppercase {
                return result + " " + character.lowercased()
            } else {
                return result + String(character)
            }
        }
        
        return spacedString
    }
}
