//
//  StoreViewModel.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 11/10/24.
//

import SwiftUI

class StoreViewModel: ObservableObject {
    @EnvironmentObject var service: Service

    func buyAcessory(item: Accessory, currency: MoneyType, price: Int) -> Bool {
        if currency == .coin {
            guard let user = service.getUser() else { return false}
            let coinBalance = user.coins
            if coinBalance >= price {
                decreaseBalance(user: user, currency: .coin, amount: price)
                return true
            }
        } else {
            guard let user = service.getUser() else { return false}
            let gemBalance = user.gems
            if gemBalance >= price {
                decreaseBalance(user: user, currency: .gem, amount: price)
                return true
            }
        }
        return false
    }

    func decreaseBalance(user: User, currency: MoneyType, amount: Int) {
        if currency == .coin {
            user.coins -= amount
        } else {
            user.gems -= amount
        }
    }
    
//    func unlockItem(for user: User, item: Accessory) {
//        guard let user = service.getUser() else { return }
//
//        )
//    }
}
