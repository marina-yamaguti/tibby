//
//  RarityLabel.swift
//  Tibby
//
//  Created by Sofia Sartori on 06/09/24.
//

import SwiftUI

struct RarityLabel: View {
    let capsule: Image
    let rarity: String
    var body: some View {
        HStack(spacing: 8){
            capsule
                .resizable()
                .frame(width: 14, height: 14)
                .padding(.leading)
            Text(rarity)
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.trailing)
        }
        .padding(.vertical)
        .background(.tibbyBaseGrey.opacity(0.2))
        .withBorderRadius(20)
    }
}

