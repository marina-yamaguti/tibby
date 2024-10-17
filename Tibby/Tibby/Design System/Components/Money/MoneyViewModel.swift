//
//  CoinViewModel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 18/07/24.
//

import Foundation
import SwiftData
import SwiftUI

class MoneyViewModel: ObservableObject {
    @Published var moneyType: MoneyType
    @Published var value: Int
    
    private var service: Service
    
    init(moneyType: MoneyType, service: Service) {
         self.moneyType = moneyType
         self.value = 0
         self.service = service
         fetchMoneyValue()
     }
    
    func fetchMoneyValue() {
        guard let user = service.getUser() else { return }
        
        switch moneyType {
        case .coin:
            self.value = user.coins
        case .gem:
            self.value = user.gems
        }
    }
    
    func addCoins(amount: Int) {
           if moneyType == .coin {
               value += amount
           }
       }
    
    //image based on the type of money

    func getImageName() -> String {
        switch moneyType {
        case .coin:
            return "TibbyImageCoin"
        case .gem:
            return "TibbyImageGem"
        }
    }
}

//enum for the type of money
enum MoneyType: String {
    case coin = "Coin"
    case gem = "Gem"
    
}
