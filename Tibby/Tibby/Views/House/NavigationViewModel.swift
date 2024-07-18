//
//  NavigationViewModel.swift
//  Tibby
//
//  Created by Sofia Sartori on 18/07/24.
//

import Foundation

class NavigationViewModel: ObservableObject {
    @Published var tibby: Tibby
    
    init(tibby: Tibby) {
        self.tibby = tibby
    }
}
