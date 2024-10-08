//
//  StreakCountComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 20/09/24.
//

import SwiftUI

struct StreakCountComponent: View {
    @State var streak = GameStreak()
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            Image(streak.currentStreak > 0 ? "CapsuleStreakOn" : "CapsuleStreakOff")
                .resizable()
                .scaledToFill()
                .frame(width: 23, height: 23)
            
            Text("\(streak.currentStreak)")
                .font(.typography(.body))
                .foregroundStyle(.tibbyBaseBlack)
        }
    }
}


#Preview {
    StreakCountComponent()
}
