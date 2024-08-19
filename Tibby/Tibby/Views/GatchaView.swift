//
//  GatchaView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 16/08/24.
//

import SwiftUI

/// A view depicting the Gatcha game.
struct GatchaView: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    
    var body: some View {
        MoneyView(viewModel: MoneyViewModel(moneyType: .gem, service: service))
        Button(action: {}, label: {ButtonLabel(type: .primary, image: TibbySymbols.roll.rawValue, text: "Roll")})
        
    }
}

#Preview {
    GatchaView()
}
