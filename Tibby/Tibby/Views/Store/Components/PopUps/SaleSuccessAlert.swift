//
//  SaleSuccessAlert.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 10/10/24.
//

import SwiftUI

struct SaleSuccessAlert: View {
    @Binding var isPresented: Bool
    var image: String
    var price: Int
    
    var body: some View {
        
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text("Success")
                    .font(.typography(.label))
                    .foregroundStyle(.tibbyBaseBlack)
                    .padding(.top, 16)
                
                Image(image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .scaleEffect(1.5)
            }
            
            
            Text("The purchased item has been added to your account.")
                .font(.typography(.label2))
                .multilineTextAlignment(.center)
                .foregroundColor(.tibbyBaseBlack)
                .frame(minHeight: 64)
            
            Divider()
            
            HStack(spacing: 0) {
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(alignment: .center, spacing: 8) {
                        Image(TibbySymbols.xmarkWhite.rawValue)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 12, height: 12)
                            .padding(4)
                            .background {
                                Circle()
                                    .fill(.tibbyBaseSaturatedGreen)
                            }
                        Text("Ok")
                            .font(.typography(.body2))
                            .foregroundStyle(.tibbyBaseBlack)
                    }
                }
                
                Spacer()
                
                
            }
            .frame(maxHeight: 50)
        }
        .frame(width: 270, height: 245)
        .background(.tibbyBaseWhite.opacity(0.9))
        .cornerRadius(25)
        .shadow(radius: 10)
    }
}


#Preview {
    SaleSuccessAlert(isPresented: .constant(true), image: "SpyHat-wardrobe", price: 20)
}

