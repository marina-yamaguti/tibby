//
//  StreakUpComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/09/24.
//

import SwiftUI

struct StreakUpComponent: View {
    @ObservedObject var streak: GameStreak  
    
    var body: some View {
        ZStack {
            Image(streak.currentStreak > 0 ? "CapsuleStreakOn" : "CapsuleStreakOff")
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 48)
            
            Text("\(streak.currentStreak)")
                .font(.typography(.body))
                .foregroundStyle(.tibbyBaseDarkBlue)
                .padding(4)
                .offset(x: 10, y: 15)
        }
    }
}

#Preview {
    StreakUpComponent(streak: GameStreak())  // Preview with a sample streak
}
