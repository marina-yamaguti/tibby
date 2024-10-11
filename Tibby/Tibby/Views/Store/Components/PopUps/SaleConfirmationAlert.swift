//
//  SaleConfirmationAlert.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 10/10/24.
//

import SwiftUI

struct SaleConfirmationAlert: View {
    @Binding var isPresented: Bool
    var image: String
    var itemName: String
    var price: Int
    
    var body: some View {
        
        VStack(spacing: 0) {            
            VStack(spacing: 0) {
                Image(image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .scaleEffect(1.5)
                    .frame(maxWidth: 86)
                
                Text(itemName)
                    .font(.typography(.label2))
                    .foregroundStyle(.tibbyBaseWhite)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background {
                        Capsule()
                            .fill(.tibbyBaseBlack)
                    }
            }
            .padding(.horizontal, 100)
            
            
            Text("Are you sure you want to buy this item?")
                .font(.typography(.body2))
                .multilineTextAlignment(.center)
                .foregroundColor(.tibbyBaseBlack)
                .frame(minHeight: 64)
                .padding(16)
            
            Divider()
            
            HStack(spacing: 0) {
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    HStack(alignment: .center, spacing: 8) {
                        Image(TibbySymbols.xmarkWhite.rawValue)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 12, height: 12)
                            .padding(4)
                            .background {
                                Circle()
                                    .fill(.tibbyBaseGrey)
                            }
                        Text("Cancel")
                            .font(.typography(.body2))
                            .foregroundStyle(.tibbyBaseBlack)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                Spacer()
                
                Divider()
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(alignment: .center, spacing: 8) {
                        Image("TibbyImageCoin")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                        
                        Text("\(price)")
                            .font(.typography(.body2))
                            .foregroundStyle(.tibbyBaseBlack)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
                Spacer()
                
            }
            .frame(maxHeight: 50)
        }
        .frame(width: 300, height: 309)
        .background(.tibbyBaseWhite.opacity(0.9))
        .cornerRadius(25)
        .shadow(radius: 10)
    }
}


#Preview {
    SaleConfirmationAlert(isPresented: .constant(true), image: "SpyHat-wardrobe", itemName: "Spy Hat", price: 20)
}

