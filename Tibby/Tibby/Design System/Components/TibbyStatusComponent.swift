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
                .shadow(color: Color(red: 0.16, green: 0.17, blue: 0.22).opacity(0.2), radius: 2, x: 0, y: 0)
                .frame(width: 17, height: 17)

            Spacer()
            Image(TibbySymbols.sleepy.rawValue)
                .resizable()
                .renderingMode(.template) // Set the image rendering mode to template
                .foregroundStyle(getProgressColor(progress: sleep))
                .shadow(color: Color(red: 0.16, green: 0.17, blue: 0.22).opacity(0.2), radius: 2, x: 0, y: 0)
                .frame(width: 17, height: 17)

            Spacer()
            Image(TibbySymbols.dumbbell.rawValue)
                .resizable()
                .renderingMode(.template) // Set the image rendering mode to template
                .foregroundStyle(getProgressColor(progress: play))
                .shadow(color: Color(red: 0.16, green: 0.17, blue: 0.22).opacity(0.2), radius: 2, x: 0, y: 0)
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
