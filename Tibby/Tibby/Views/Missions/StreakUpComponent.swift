//
//  StreakUpComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/09/24.
//

import SwiftUI

struct StreakUpComponent: View {
    @State var streakCount: Int
    var body: some View {
        ZStack {
            Image("CapsuleStreakOn")
                .resizable()
                .frame(width: 36, height: 36)
            Text("\(streakCount)")
                .font(.typography(.body))
                .foregroundStyle(.tibbyBaseDarkBlue)
                .padding(4)
                .offset(x: 10, y: 10)
        }
    }
}

#Preview {
    StreakUpComponent(streakCount: 0)
}
