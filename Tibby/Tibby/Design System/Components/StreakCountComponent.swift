//
//  StreakCountComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 04/09/24.
//

import SwiftUI

struct StreakCountComponent: View {
    @State var isOn: Bool
    @State var streakCount: Int
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(isOn ? "CapsuleStreakOn" : "CapsuleStreakOff")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)

            Text("\(streakCount)")
                .font(.typography(.body))
                .foregroundStyle(.tibbyBaseBlack)

        }
    }
}

#Preview {
    StreakCountComponent(isOn: true, streakCount: 2)
}

