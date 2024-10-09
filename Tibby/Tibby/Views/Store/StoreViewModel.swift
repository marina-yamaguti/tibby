//
//  StoreViewModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 23/09/24.
//

class StoreViewModel {
    
    
    
    
    
    enum Sections: CaseIterable {
        case gatchas
        case items
        
        var description: String {
            switch self {
            case .gatchas:
                "Gatchas"
            case .items:
                "Items"
            }
        }
    }
}
