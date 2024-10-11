//
//  StoreItemComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/10/24.
//

import SwiftUI


struct StoreItemComponent: View {
    var image: String
    var itemName: String
    var currencyType: MoneyType
    var price: Int
    @Binding var showConfirmationAlert: Bool
    var tapHandler: () -> Void
    
    var body: some View {
        VStack {
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(2.0)
                    .frame(width: 86, height: 86)
                Text(itemName)
                    .font(.typography(.label2))
                    .foregroundStyle(.tibbyBaseBlack)
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background {
                        Capsule()
                            .fill(.tibbyBaseWhite)
                            .opacity(0.5)
                    }
            }
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.tibbyBasePearlBlue)
            }
            HStack {
                Spacer()
                Image(currencyType == .coin ? "TibbyImageCoin" : "TibbyImageGem")
                Text("\(price)")
                    .font(.typography(.label))
                    .foregroundStyle(.tibbyBaseWhite)
                Spacer()
                
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .background {
                Capsule()
                    .fill(.tibbyBaseBlack)
            }
            .onTapGesture {
                tapHandler()
            }
        }
        .shadow(color: Color(red: 0.16, green: 0.17, blue: 0.22).opacity(0.2), radius: 2, x: 0, y: 0)
    }
}

