//
//  GoalsComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/09/24.
//

import SwiftUI

struct GoalsCard: View {
    @Binding var showEdit: Bool
    @Binding var exercise: Int
    @Binding var energy: Int
    @Binding var steps: Int
    @Binding var sleep: Int

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("My Goals")
                    .font(.typography(.body))
                    .foregroundStyle(.tibbyBaseBlack)
                Spacer()
                Button(action: {showEdit = true}) {
                    ButtonLabel(type: .secondary, image: TibbySymbols.pen.rawValue, text: "")
                }
                .buttonSmallRounded(bgColor: .black.opacity(0.5))
                .padding(.trailing, 16)
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    GoalsComponent(value: exercise, title: "Daily Exercise", description: "minutes/day")
                    GoalsComponent(value: energy, title: "Daily Energy Goal", description: "calories/day")
                    GoalsComponent(value: steps, title: "Daily Steps", description: "steps/day")
                    GoalsComponent(value: sleep, title: "Daily Sleep Time", description: "hours/day")
                }
            }
        }
    }
}
