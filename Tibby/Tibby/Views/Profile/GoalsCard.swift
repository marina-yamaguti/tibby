//
//  GoalsComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/09/24.
//

import SwiftUI

struct GoalsCard: View {
    @State var exercise: Int = UserDefaults.standard.value(forKey: "workout") as? Int ?? 30
    @State var energy: Int = UserDefaults.standard.value(forKey: "energy") as? Int ?? 110
    @State var steps: Int = UserDefaults.standard.value(forKey: "steps") as? Int ?? 500
    @State var sleep: Int = UserDefaults.standard.value(forKey: "sleep") as? Int ?? 8

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("My Goals")
                    .font(.typography(.body))
                    .foregroundStyle(.tibbyBaseBlack)
                Spacer()
                Button(action: {}) {
                    ButtonLabel(type: .secondary, image: TibbySymbols.pen.rawValue, text: "")
                }
                .buttonSmallRounded(bgColor: .black.opacity(0.5))
                .padding(.trailing, 16)
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    GoalsComponent(value: exercise, title: "Daily Exercise", description: "minutes/day")
                    GoalsComponent(value: energy, title: "Daily Energy Goal", description: "calories/day")
                    GoalsComponent(value: energy, title: "Daily Steps", description: "steps/day")
                    GoalsComponent(value: energy, title: "Daily Sleep Time", description: "hours/day")
                }
            }
        }
    }
}
