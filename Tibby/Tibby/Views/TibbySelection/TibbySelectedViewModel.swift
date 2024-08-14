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
    @Published var tibby: Tibby
    
    init(tibby: Tibby) {
        self.tibby = tibby
    }
    
    var color: Color {
        switch tibby.collection {
        case "seaSeries":
            return Color.tibbyBaseBlue
        case "houseSeries":
            return Color.tibbyBasePink
        case "forestSeries":
            return Color.tibbyBaseGreen
        case "beachSeries":
            return Color.tibbyBaseOrange
        case "foodSeries":
            return Color.tibbyBaseRed
        case "urbanSeries":
            return Color.tibbyBaseGrey
        default:
            return Color.gray
        }
    }
    
    var species: String {
        return tibby.species
    }
    
    var rarity: String {
        return tibby.rarity
    }
    
    var description: String {
        return tibby.details.description
    }
    
    var isSelected: Bool {
        #warning("tem q ser is selected")
        return tibby.isUnlocked
    }
}
