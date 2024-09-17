//
//  OnboardingView3.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//

import SwiftUI

struct OnboardingView3: View {
    @EnvironmentObject var constants: Constants
    @Binding var name: String
    @State var exercise: Int = UserDefaults.standard.value(forKey: "workout") as? Int ?? 30 {
        didSet {
            UserDefaults.standard.setValue(exercise, forKey: "workout")
        }
    }
    @State var energy: Int = UserDefaults.standard.value(forKey: "energy") as? Int ?? 110 {
        didSet {
            UserDefaults.standard.setValue(energy, forKey: "energy")
        }
    }
    @State var steps: Int = UserDefaults.standard.value(forKey: "steps") as? Int ?? 500 {
        didSet {
            UserDefaults.standard.setValue(steps, forKey: "steps")
        }
    }
    @State var sleep: Int = UserDefaults.standard.value(forKey: "sleep") as? Int ?? 8 {
        didSet {
            UserDefaults.standard.setValue(sleep, forKey: "sleep")
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CustomTextField(input: $name, prompt: "How should we call you?", placeholder: "Name")
                    .padding(.bottom, 16)
                CustomStepper(value: $exercise, step: 5, range: 5...1440, title: "Daily Exercise", description: "minutes/day", stepperType: .firstTime)
                CustomStepper(value: $energy, step: 10, range: 110...1440, title: "Daily Energy Goal", description: "calories/day", stepperType: .firstTime)
                CustomStepper(value: $steps, step: 500, range: 500...10000, title: "Daily Steps", description: "steps/day", stepperType: .firstTime)
                CustomStepper(value: $sleep, step: 1, range: 6...12, title: "Daily Sleep Time", description: "hours/day", stepperType: .firstTime)

            }
            .onDisappear {
                saveGoals()
            }
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
        }.scrollIndicators(.hidden)
    }
    
    func saveGoals() {
        UserDefaults.standard.set(exercise, forKey: "workout")
        UserDefaults.standard.set(energy, forKey: "energy")
        UserDefaults.standard.set(steps, forKey: "steps")
        UserDefaults.standard.set(sleep, forKey: "sleep")
        print("Goals saved: exercise \(exercise), energy \(energy), steps \(steps), sleep \(sleep)")
    }
}

