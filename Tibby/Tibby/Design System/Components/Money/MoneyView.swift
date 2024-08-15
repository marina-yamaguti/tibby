//
//  CoinView.swift
//  Tibby
//
//  Created by Marina Yamaguti on 18/07/24.
//

import SwiftUI

struct MoneyView: View {
    @ObservedObject var viewModel: MoneyViewModel
    
    var body: some View {
        HStack {
            Image(viewModel.getImageName())
                .resizable()
                .frame(width: 22, height: 22)
            Text("\(viewModel.value)")
                .font(.typography(.body))
        }
    }
}

//#Preview {
//    MoneyView(viewModel: MoneyViewModel(moneyType: .coin, service: Service()))
//}
