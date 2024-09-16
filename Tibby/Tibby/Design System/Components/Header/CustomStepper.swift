//
//  CustomStepper.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/08/24.
//

import SwiftUI

enum StepperType {
    case firstTime, editing
}
/// A custom stepper component for adjusting a numeric value within a defined range.
/// 
/// `CustomStepper` allows users to increment or decrement a value by a specified step size within a given range.
/// It displays the current value along with a title and description, making it useful for setting and displaying numeric preferences or settings.
struct CustomStepper: View {
    /// The current value of the stepper.
    @Binding var value: Int
    
    /// The amount by which the value should be incremented or decremented.
    var step: Int
    
    /// The range within which the value can be adjusted.
    var range: ClosedRange<Int>
    
    /// The title displayed above the stepper.
    var title: String
    
    /// A description displayed below the value, providing context for what the value represents.
    var description: String
    
    var stepperType: StepperType
    
    var body: some View {
        VStack(spacing: 4) {
            // Title of the stepper
            Text(title)
                .font(.typography(.body2))
                .foregroundStyle(stepperType == .editing ? .tibbyBaseWhite : .tibbyBaseBlack)
            HStack {
                // Decrement button
                Button(action: {
                    if value > range.lowerBound {
                        value -= step
                    }
                }) {
                    Image(TibbySymbols.minus.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14)
                }
                .buttonSecondary(bgColor: value > range.lowerBound ? .black.opacity(0.5) : .black.opacity(0.5))
                .disabled(value <= range.lowerBound)
                
                Spacer()
                
                // Display the current value and description
                VStack(spacing: 8) {
                    Text("\(value)")
                        .font(.typography(.title))
                        .foregroundStyle(stepperType == .editing ? .tibbyBaseWhite : .tibbyBaseBlack)
                    Text(description)
                        .font(.typography(.label2))
                        .foregroundStyle(stepperType == .editing ? .tibbyBaseWhite : .tibbyBaseGrey)
                }
                
                Spacer()
                
                // Increment button
                Button(action: {
                    if value < range.upperBound {
                        value += step
                    }
                }) {
                    Image(TibbySymbols.plus.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14)
                }
                .buttonSecondary(bgColor: value < range.upperBound ? .black.opacity(0.5) : .black.opacity(0.5))
                .disabled(value >= range.upperBound)
            }
        }
        .padding(8)
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(stepperType == .editing ? .tibbyBaseWhite : .tibbyBaseBlack, lineWidth: 1)
        }
    }
}
