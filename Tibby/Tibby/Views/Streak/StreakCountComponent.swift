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
        HStack(alignment: .bottom) {
            Image(streak.currentStreak > 0 ? "CapsuleStreakOn" : "CapsuleStreakOff")
                .resizable()
                .frame(width: 21, height: 27)
            
            Text("\(streak.currentStreak)")
                .font(.typography(.body))
                .foregroundStyle(.tibbyBaseBlack)
        }
    }
}


#Preview {
    StreakCountComponent()
}
