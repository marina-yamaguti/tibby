//
//  OnboardingView3.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//

import SwiftUI

struct OnboardingView3: View {
    @EnvironmentObject var constants: Constants
    @State var name = ""
    @State var exercise: Int = 5
    @State var energy: Int = 10
    @State var steps: Int = 500
    
    var body: some View {
        ScrollView {
            VStack {
                CustomTextField(prompt: "How should we call you?", placeholder: "Name")
                    .padding(.bottom, 16)
                CustomStepper(value: $exercise, step: 5, range: 30...1440, title: "Daily Exercise", description: "minutes/day")
                CustomStepper(value: $energy, step: 10, range: 110...1440, title: "Daily Energy Goal", description: "calories/day")
                CustomStepper(value: $steps, step: 500, range: 500...1440, title: "Daily Steps", description: "steps/day")
                CustomStepper(value: $steps, step: 1, range: 6...12, title: "Daily Sleep Time", description: "hours/day")

            }
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
        }
    }
}

