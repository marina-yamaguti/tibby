//
//  AdBanner.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 10/10/24.
//

import SwiftUI

struct AdBanner: View {
    var body: some View {
        HStack {
            Image("CoinBundleSmall")
                .frame(width: 78, height: 78)
            Spacer()

            VStack(spacing: 16) {
                Text("10 coins")
                    .font(.typography(.body))
                    .foregroundStyle(.tibbyBaseBlack)
                Button {
                    //action ad here
                } label: {
                    HStack {
                        Image(TibbySymbols.adLight.rawValue)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                        Text("Free")
                            .font(.typography(.label)).bold()
                            .foregroundStyle(.tibbyBaseWhite)
                    }
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.tibbyBaseCosmicPurple)
                    }
                }
                    
            }
        }
        .padding(.horizontal, 32)

        .padding(8)
        .background() {
            RoundedRectangle(cornerRadius: 20)
                .fill(.tibbyBasePearlBlue)
        }
    }
}

#Preview {
    AdBanner()
}
