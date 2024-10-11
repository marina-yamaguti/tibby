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
            itemImageSection
            itemInfoSection
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.tibbyBasePearlBlue)
        )
        .onTapGesture {
            tapHandler()
        }
        .customShadow()
    }
    
    private var itemImageSection: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 86, height: 86)
        }
    }
    
    private var itemInfoSection: some View {
        VStack(spacing: 12) {
            itemNameLabel
            priceSection
        }
    }
    
    private var itemNameLabel: some View {
        Text(itemName)
            .font(.typography(.label2))
            .foregroundStyle(.tibbyBaseBlack)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(.tibbyBaseWhite)
                    .opacity(0.5)
            )
    }
    
    private var priceSection: some View {
        HStack {
            Spacer()
            Image(currencyType == .coin ? "TibbyImageCoin" : "TibbyImageGem")
            Text("\(price)")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseWhite)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(.tibbyBaseBlack)
        )
    }
}
