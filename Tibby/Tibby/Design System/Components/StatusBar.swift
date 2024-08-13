//
//  StatusBar.swift
//  Tibby
//
//  Created by Sofia Sartori on 09/08/24.
//

import SwiftUI

struct StatusBar: View {
    @EnvironmentObject var service: Service
    var body: some View {
        HStack(alignment: .top) {
            HStack {
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 50)
                        .aspectRatio(8, contentMode: .fit)
                        .foregroundStyle(.green)
                        .frame(height: 9.5)
                    Text("happy")
                        .foregroundStyle(.tibbyBaseBlack)
                        .font(.typography(.label))
                        .padding(.top, 4)
                }
                VStack {
                    RoundedRectangle(cornerRadius: 50)
                        .aspectRatio(8, contentMode: .fit)
                        .foregroundStyle(.green)
                        .frame(height: 9.5)
                    Spacer()
                }
            }.padding(.trailing, 8)
            Spacer()
            MoneyView(viewModel: MoneyViewModel(moneyType: .gem, service: service))
                .padding(.horizontal)
            MoneyView(viewModel: MoneyViewModel(moneyType: .coin, service: service))
                .padding(.trailing)
            
        }.frame(height: 35)
    }
}

