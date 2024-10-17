//
//  SleepGoalComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 16/10/24.
//

import SwiftUI

struct SleepGoalComponent: View {
    let goal: Int
    let title: String
    let type: String
    
    var body: some View {
        HStack {
            Text("\(title):")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBasePink)
                .bold()
            Spacer()
            Text("\(formatTime(from: goal)) \(type)")
                .font(.typography(.title))
                .foregroundStyle(.tibbyBaseWhite)
        }
        .padding(8)
        .cornerRadius(40)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.tibbyBasePink, lineWidth: 2)
        )
    }
    func formatTime(from hours: Int) -> String {
        let totalMinutes = hours * 60
        let hrs = totalMinutes / 60
        let mins = totalMinutes % 60

        return String(format: "%02d:%02d", hrs, mins)
    }
}

#Preview {
    SleepGoalComponent(goal: 07, title: "Sleep Goal", type: "hours")
        .background(.black)
}
