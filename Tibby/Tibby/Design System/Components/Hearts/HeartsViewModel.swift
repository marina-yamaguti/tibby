//
//  HeartsViewModel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 18/07/24.
//

import Foundation
import SwiftUI

class HeartsViewModel: ObservableObject {
    @Published var category: Category
    @Published var value: Int
    
    private var service: Service
    
    //current tibby
    var tibby: Tibby

    
    init(tibby: Tibby, category: Category, service: Service) {
        self.tibby = tibby
        self.category = category
        self.value = 0
        self.service = service
        fetchCategoryValue()
    }
    
    func fetchCategoryValue() {
        
        switch category {
        case .hunger:
            self.value = tibby.hunger
        case .sleep:
            self.value = tibby.sleep
        case .fun:
            self.value = tibby.happiness
        }
    }
    
    func getHeartImage(index: Int) -> String {
        let threshold = value / 3
        return index < threshold ? "heartFull" : "heartEmpty"
    }
}

enum Category: String {
    case hunger = "Hunger"
    case sleep = "Sleep"
    case fun = "Fun"
}