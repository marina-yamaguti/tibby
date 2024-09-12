//
//  OfferedRewardComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 11/09/24.
//

import SwiftUI

struct OfferedRewardComponent: View {
    @State var isCompleted: Bool
    var reward: Reward
    var body: some View {
        ZStack {
            Image(reward.rewardType == .coin ? "TibbyImageCoin" : "TibbyImageGem")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(8)


            Text("\(reward.rewardValue)")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseDarkBlue)
                .padding(4)
                .background {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.tibbyBaseWhite.opacity(0.7))
                }
                .offset(x: 10, y: 10)
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(isCompleted ? .tibbyBaseGrey: .tibbyBaseGreen)
        }
    }
}

#Preview {
    OfferedRewardComponent(isCompleted: true, reward: Reward(rewardValue: 10, rewardType: .coin))
}
