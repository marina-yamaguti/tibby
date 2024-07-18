//
//  CoinViewModel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 18/07/24.
//

import Foundation

class MoneyViewModel: ObservableObject {
    @Published var moneyType: MoneyType
    @Published var value: Int
    
    init(moneyType: MoneyType, value: Int) {
        self.moneyType = moneyType
        self.value = value
    }
    
    func getImageName() -> String {
        switch moneyType {
        case .coin:
            return "TibbyImageCoin"
        case .gem:
            return "TibbyImageRedCoin"
        }
    }
}

enum MoneyType {
    case coin
    case gem
}
