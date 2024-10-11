//
//  StoreCurrencyComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 10/10/24.
//

import SwiftUI

struct StoreCurrencyComponent: View {
    @Environment(\.locale) var locale
    private var quantity: Int
    private var currencyType: MoneyType
    private var price: Double
    private var bundleSize: BundleSize
    private var isDiscounted: Bool
    private var discountPrice: Double
    private var discountPercentage: Int
    
    init(quantity: Int, currencyType: MoneyType, price: Double, bundleSize: BundleSize, isDiscounted: Bool, discountPrice: Double, discountPercentage: Int) {
        self.quantity = quantity
        self.currencyType = currencyType
        self.price = price
        self.bundleSize = bundleSize
        self.isDiscounted = isDiscounted
        self.discountPrice = discountPrice
        self.discountPercentage = discountPercentage
    }
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                VStack {
                    imageSection
                    quantityLabel
                    priceSection
                }
                if isDiscounted {
                    discountLabel
                        .position(x: proxy.size.width - 35, y: proxy.size.height - 130)
                }
            }
            .customShadow()
        }
    }
    
    private var imageSection: some View {
        VStack {
            Image("\(currencyType.rawValue)Bundle\(bundleSize.rawValue)")
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(maxWidth: 132)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.tibbyBasePearlBlue)
        )
    }
    
    private var quantityLabel: some View {
        Text("\(quantity) \(currencyType.rawValue.lowercased())s")
            .font(.typography(.label))
            .foregroundStyle(.tibbyBaseWhite)
            .padding(8)
            .frame(maxWidth: 132)
            .background(
                Capsule()
                    .fill(currencyType == .coin ? .tibbyBaseSkyBlue : .tibbyBaseRed)
            )
    }
    
    private var priceSection: some View {
        HStack {
            Spacer()
            Text(isDiscounted ? discountPrice : price, format: .currency(code: locale.currency?.identifier ?? "USD"))
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
                .kerning(0.1)
        }
        .padding(.top, 8)
        .overlay(
            discountedPriceOverlay
        )
    }
    
    private var discountedPriceOverlay: some View {
        Group {
            if isDiscounted {
                HStack {
                    Text(price, format: .currency(code: locale.currency?.identifier ?? "USD"))
                        .font(.typography(.label2))
                        .foregroundStyle(.tibbyBaseSaturatedRed)
                        .strikethrough()
                    Spacer()
                }
            }
        }
    }
    
    private var discountLabel: some View {
        Text("\(discountPercentage)% Off")
            .font(.typography(.label))
            .foregroundStyle(.tibbyBaseBlack)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.tibbyBaseSaturatedGreen)
            )
    }
}

enum BundleSize: String {
    case large = "Large"
    case medium = "Medium"
    case small = "Small"
}
