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
        VStack {
            CustomTextField(prompt: "How should we call you?", placeholder: "Name")
            CustomStepper(value: $exercise, step: 5, range: 10...1440, title: "Daily Exercise", description: "minutes/day")
            CustomStepper(value: $energy, step: 5, range: 10...1440, title: "Daily Energy Goal", description: "calories/day")
            CustomStepper(value: $steps, step: 5, range: 500...1440, title: "Daily Steps", description: "steps/day")
        }
        .padding(EdgeInsets(top: 0, leading: 48, bottom: 0, trailing: 48))
    }
}

