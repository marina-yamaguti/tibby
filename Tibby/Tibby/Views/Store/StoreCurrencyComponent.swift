//
//  StoreCurrencyComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 10/10/24.
//

import SwiftUI
enum BundleSize: String {
    case large = "Large"
    case medium = "Medium"
    case small = "Small"
}

struct StoreCurrencyComponent: View {
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
        ZStack {
            VStack {
                VStack {
                    Image("\(currencyType.rawValue + "Bundle" + bundleSize.rawValue)")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(maxWidth: 132)
                }
                .padding(16)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.tibbyBasePearlBlue)
                }
                Text("\(quantity) \(currencyType.rawValue.lowercased())s")
                    .font(.typography(.label))
                    .foregroundStyle(.tibbyBaseWhite)
                    .padding(8)
                    .frame(maxWidth: 132)
                    .background {
                        Capsule()
                            .fill(currencyType == .coin ? .tibbyBaseSkyBlue : .tibbyBaseRed)
                    }
                HStack {
                    Spacer()
                    Text(isDiscounted ? discountPrice : price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(.typography(.label))
                        .foregroundStyle(.tibbyBaseBlack)
                        .kerning(0.1)

                }
                .padding(.top, 8)
                .overlay {
                    if isDiscounted {
                        HStack {
                            Text(price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .font(.typography(.label2))
                                .foregroundStyle(.tibbyBaseSaturatedRed)
                                .strikethrough()
                            Spacer()
                        }
                    }
                }
            }
            Text("\(discountPercentage)% Off")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.tibbyBaseSaturatedGreen)

                }
                .position(x: 100, y: 2)
                .frame(alignment: .trailing)
        }
        .shadow(color: Color(red: 0.16, green: 0.17, blue: 0.22).opacity(0.2), radius: 2, x: 0, y: 0)
    }
}


#Preview {
    StoreCurrencyComponent(quantity: 110, currencyType: .coin, price: 19.9, bundleSize: .medium, isDiscounted: false, discountPrice: 17.9, discountPercentage: 10)
        .frame(width: 132, height: 132)

}


