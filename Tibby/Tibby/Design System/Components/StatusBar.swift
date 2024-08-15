//
//  StatusBar.swift
//  Tibby
//
//  Created by Sofia Sartori on 09/08/24.
//

import SwiftUI

struct StatusBar: View {
    @EnvironmentObject var service: Service
    @State var tibby: Tibby
    let necessityName: String
    var body: some View {
        HStack(alignment: .top) {
//            HStack {
//                VStack(alignment: .leading) {
//                    RoundedRectangle(cornerRadius: 50)
//                        .aspectRatio(8, contentMode: .fit)
//                        .foregroundStyle(.green)
//                        .frame(height: 9.5)
//                    Text(necessityName)
//                        .foregroundStyle(.tibbyBaseBlack)
//                        .font(.typography(.label))
//                        .padding(.top, 4)
//                }
//                VStack {
//                    RoundedRectangle(cornerRadius: 50)
//                        .aspectRatio(8, contentMode: .fit)
//                        .foregroundStyle(.green)
//                        .frame(height: 9.5)
//                    Spacer()
//                }
//            }
//                .padding(.trailing, 8)
            VStack(/*alignment: .leading*/) {
                switch necessityName {
                case "sleep":
                    Text("\(tibby.sleep)/100")
                        .foregroundStyle(.tibbyBaseBlack)
                        .font(.typography(.title))
                        .padding(.top, 4)
                    
                case "happiness":
                    Text("\(tibby.happiness)/100")
                        .foregroundStyle(.tibbyBaseBlack)
                        .font(.typography(.title))
                        .padding(.top, 4)
                    
                case "hunger":
                    Text("\(tibby.hunger)/100")
                        .foregroundStyle(.tibbyBaseBlack)
                        .font(.typography(.title))
                        .padding(.top, 4)
                default:
                    EmptyView()
                }
                Text(necessityName)
                    .foregroundStyle(.tibbyBaseBlack)
                    .font(.typography(.label))
            }
            //.padding(.trailing, 8)
//            MoneyView(viewModel: MoneyViewModel(moneyType: .gem, service: service))
//                .padding(.horizontal)
//            MoneyView(viewModel: MoneyViewModel(moneyType: .coin, service: service))
//                .padding(.trailing)
            
        }
            //.frame(height: 35)
            .padding(.top, 16)
    }
}

