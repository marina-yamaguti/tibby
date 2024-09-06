//
//  TibbyStatusComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 30/08/24.
//

import SwiftUI

struct TibbyStatusComponent: View {
    @State var hunger: Int
    @State var sleep: Int
    @State var play: Int
    
    var body: some View {
        HStack {
            Image(TibbySymbols.food.rawValue)
                .resizable()
                .renderingMode(.template) // Set the image rendering mode to template
                .foregroundStyle(getProgressColor(progress: hunger))
                .frame(width: 17, height: 17)

            Spacer()
            Image(TibbySymbols.sleepy.rawValue)
                .resizable()
                .renderingMode(.template) // Set the image rendering mode to template
                .foregroundStyle(getProgressColor(progress: sleep))
                .frame(width: 17, height: 17)

            Spacer()
            Image(TibbySymbols.dumbbell.rawValue)
                .resizable()
                .renderingMode(.template) // Set the image rendering mode to template
                .foregroundStyle(getProgressColor(progress: play))
                .frame(width: 17, height: 17)

        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 50)
                .fill(.tibbyBaseWhite.opacity(0.5))
        }
    }
    
    func getProgressColor(progress: Int) -> Color {
        if progress < 33 {
            return .tibbyBaseSaturatedRed
        } else if progress < 67 {
            return .tibbyBaseSaturatedYellow
        }
        else {
            return .tibbyBaseSaturatedGreen
        }
    }
    
}
