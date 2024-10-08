//
//  CustomStepper.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/08/24.
//

import SwiftUI

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
    
    var body: some View {
        VStack {
            // Title of the stepper
            Text(title)
                .font(.typography(.body))
            
            HStack {
                // Decrement button
                Button(action: {
                    if value > range.lowerBound {
                        value -= step
                    }
                }) {
                    Image(TibbySymbols.play.rawValue)
                }
                .buttonSecondary(bgColor: value > range.lowerBound ? .black : .black)
                .disabled(value <= range.lowerBound)
                
                Spacer()
                
                // Display the current value and description
                VStack {
                    Text("\(value)")
                        .font(.typography(.title))
                    Text(description)
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseGrey)
                }
                
                Spacer()
                
                // Increment button
                Button(action: {
                    if value < range.upperBound {
                        value += step
                    }
                }) {
                    Image(TibbySymbols.play.rawValue)
                }
                .buttonSecondary(bgColor: value < range.upperBound ? .black : .black)
                .disabled(value >= range.upperBound)
            }
        }
        .padding(8)
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.tibbyBaseBlack, lineWidth: 1)
        }
    }
}
