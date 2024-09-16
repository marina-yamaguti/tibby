//
//  WorkoutComponent.swift
//  Tibby
//
//  Created by Sofia Sartori on 12/09/24.
//

import SwiftUI

struct WorkoutComponent: View {
    let goal: Int
    let title: String
    let type: String
    
    var body: some View {
        HStack {
            Text("\(title):")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBaseGreen)
                .bold()
            Spacer()
            Text("\(String(goal)) \(type)")
                .font(.typography(.title))
                .foregroundStyle(.tibbyBaseWhite)
        }
        .padding(8)
        .cornerRadius(40)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.tibbyBaseGreen, lineWidth: 2)
        )
            
    }
}

#Preview {
    WorkoutComponent(goal: 30, title: "Exercise goal", type: "min")
}
