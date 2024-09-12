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
    @State var exercise: Int = UserDefaults.standard.value(forKey: "workout") as? Int ?? 30
    @State var energy: Int = UserDefaults.standard.value(forKey: "energy") as? Int ?? 110
    @State var steps: Int = UserDefaults.standard.value(forKey: "steps") as? Int ?? 500
    @State var sleep: Int = UserDefaults.standard.value(forKey: "sleep") as? Int ?? 8
    
    var body: some View {
        ScrollView {
            VStack {
                CustomTextField(input: $name, prompt: "How should we call you?", placeholder: "Name")
                    .padding(.bottom, 16)
                CustomStepper(value: $exercise, step: 5, range: 5...1440, title: "Daily Exercise", description: "minutes/day")
                CustomStepper(value: $energy, step: 10, range: 110...1440, title: "Daily Energy Goal", description: "calories/day")
                CustomStepper(value: $steps, step: 500, range: 500...1440, title: "Daily Steps", description: "steps/day")
                CustomStepper(value: $sleep, step: 1, range: 6...12, title: "Daily Sleep Time", description: "hours/day")

            }
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
        }.scrollIndicators(.hidden)
    }
}

