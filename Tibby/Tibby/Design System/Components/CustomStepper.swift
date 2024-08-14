//
//  CustomStepper.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/08/24.
//

import SwiftUI

struct CustomStepper: View {
    @State var value: Int
    var step: Int
    var range: ClosedRange<Int>
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.typography(.body))
            HStack {
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
                VStack {
                    Text("\(value)")
                        .font(.typography(.title))
                    Text(description)
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseGrey)
                }
                
                Spacer()
                
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



#Preview {
    CustomStepper(value: 5, step: 1, range: 0...10, title: "Daily Exercise", description: "calories/day")
}
