//
//  AdBanner.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 10/10/24.
//

import SwiftUI

import SwiftUI

struct AdBanner: View {
    var buttonAction: () -> Void
    
    var body: some View {
        HStack {
            Image("CoinBundleSmall")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 78, height: 78)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 12) {
                Text("10 coins")
                    .font(.typography(.body))
                    .foregroundStyle(.tibbyBaseBlack)
                
                adButton
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.tibbyBasePearlBlue)
        )
        .padding(.horizontal, 32)
    }
    
    private var adButton: some View {
        Button(action: buttonAction) {
            HStack {
                Image(TibbySymbols.adLight.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("Free")
                    .font(.typography(.label))
                    .bold()
                    .foregroundStyle(.tibbyBaseWhite)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.tibbyBaseCosmicPurple)
            )
        }
    }
}

#Preview {
    AdBanner {
    }
}
