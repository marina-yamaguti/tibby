//
//  GatchaViewModel.swift
//  Tibby
//
//  Created by Sofia Sartori on 20/08/24.
//

import Foundation
import SwiftUI

final class GatchaViewModel: ObservableObject {
    @Published var roll: Roll
    @Published var currentSeries: Collection = .seaSeries
    @Published var currentGatchaImage = "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase1.png"
    @Published var isAnimating = false
    
    var gatchBaseAnimation = ["https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase1.png", "gatchaBase2", "gatchaBase3", "gatchaBase4", "gatchaBase5", "gatchaBase6"]
    var gatchSeaSeriesAnimation = ["gatchaSeaSeries1"]
    
    init(roll: Roll = Roll()) {
        self.roll = roll
    }
    
    func checkForRoll(service: Service, isCoins: Bool, price: Int, collection: Collection? = nil, completion: ()->Void) -> Tibby? {
        
        var newTibby: Tibby? = nil
        
        if let user = service.getUser() {
            if isCoins {
                if user.coins >= price {
                    newTibby = self.roll.roll(collection: collection, service: service)
                    user.coins -= price
                }
            } else {
                if user.gems >= price {
                    newTibby = self.roll.roll(collection: collection, service: service)
                    user.gems -= price
                }
            }
        }
        completion()
        return newTibby
    }
    
    func updateCollectionBasedOnWeek() {
        let currentDate = Date()
        
        let calendar = Calendar.current
        let currentWeek = calendar.component(.weekOfYear, from: currentDate)
        
        let collectionIndex = currentWeek % Collection.allCases.count
        
        currentSeries = Collection.allCases[collectionIndex]
    }
    
    func animateRoll(isBase: Bool) {
        if isBase {
            for index in 0..<gatchBaseAnimation.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.3) {
                    self.currentGatchaImage = "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase\(index+1).png"
                    
                    if index == self.gatchBaseAnimation.count - 1 {
                        self.isAnimating = false
                    }
                }
            }
        }
    }
}
