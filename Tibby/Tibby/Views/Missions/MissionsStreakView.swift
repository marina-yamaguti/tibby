//
//  MissionsStreakUpComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/09/24.
//

import SwiftUI

struct MissionsStreakView: View {
    @State var streak: GameStreak
    
    var body: some View {
        VStack {
            Image(streak.currentStreak > 0 ? "ongoing1" : "broken1")
        }
    }
}

#Preview {
    MissionsStreakView(streak: GameStreak())
}
