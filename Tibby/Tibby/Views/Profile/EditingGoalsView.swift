//
//  EditingGoalsView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 16/09/24.
//

import SwiftUI

struct EditingGoalsView: View {
    @Binding var showEdit: Bool
    @Binding var exercise: Int
    @Binding var energy: Int
    @Binding var steps: Int
    @Binding var sleep: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 45)
                .fill(.tibbyBaseBlack)
            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        Text("My Goals")
                            .font(.typography(.title))
                            .foregroundStyle(.tibbyBaseWhite)
                        Spacer()
                        
                        Button(action: {showEdit = false},
                               label: {
                            ButtonLabel(type: .secondary, image: TibbySymbols.xMark.rawValue, text: "")
                        })
                        .buttonSecondary(bgColor: .black.opacity(0.5))
                    }
                    CustomStepper(value: $exercise, step: 5, range: 5...1440, title: "Daily Exercise", description: "minutes/day", stepperType: .editing)
                    CustomStepper(value: $energy, step: 10, range: 110...1440, title: "Daily Energy Goal", description: "calories/day", stepperType: .editing)
                    CustomStepper(value: $steps, step: 500, range: 500...10000, title: "Daily Steps", description: "steps/day", stepperType: .editing)
                    CustomStepper(value: $sleep, step: 1, range: 6...12, title: "Daily Sleep Time", description: "hours/day", stepperType: .editing)
                    Button(action: {
                        saveGoals()
                        showEdit = false
                    }) {
                        HStack {
                            Image(TibbySymbols.checkMark.rawValue)
                                .resizable()
                                .frame(width: 32, height: 32)
                            Text("Save")
                                .font(.typography(.title))
                                .foregroundStyle(.tibbyBaseBlack)
                                .padding(.horizontal)
                        }
                    }
                    .buttonPrimary(bgColor: .tibbyBaseYellow)
                }
            }
            .padding(16)
        }
        
    }
    func saveGoals() {
        UserDefaults.standard.set(exercise, forKey: "workout")
        UserDefaults.standard.set(energy, forKey: "energy")
        UserDefaults.standard.set(steps, forKey: "steps")
        UserDefaults.standard.set(sleep, forKey: "sleep")
        print("Goals saved: exercise \(exercise), energy \(energy), steps \(steps), sleep \(sleep)")
    }
}
