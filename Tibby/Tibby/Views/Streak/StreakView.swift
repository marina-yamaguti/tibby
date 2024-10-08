//
//  StreakAnimation.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 19/09/24.
//

import SwiftUI

struct StreakView: View {
    @State var streak = GameStreak()
    @State private var currentFrame = 1
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            if streak.currentStreak > 0 {
                    Image("ongoing1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170, height: 210)
                } else {
                Image("broken1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 210)

            }

            Text("\(streak.currentStreak)")
                .font(.typography(.display))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.bottom, 4)
            
            
            Text(streak.currentStreak > 0 ? "days streak" : "day streak")
                .font(.typography(.title))
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.bottom, 32)
            
            StreakScroll(streak: streak)
                .scrollClipDisabled()

            
            
            Spacer()
            
            Button(action: {dismiss()},
                   label: {
                HStack {
                    Image(TibbySymbols.checkmarkBlack.rawValue)
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Okay")
                        .font(.typography(.title))
                        .foregroundStyle(.tibbyBaseBlack)
                        .padding(.horizontal)
                }
            })
            .buttonPrimary(bgColor: streak.currentStreak > 0 ? .tibbyBaseYellow : .tibbyBaseWhite)
            .padding(.bottom, 32)
        }
        .navigationBarBackButtonHidden(true)
        .background {
            if streak.currentStreak > 0 {
                Color.tibbyBaseOrange
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.92, green: 0.54, blue: 0.51).opacity(0), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.92, green: 0.54, blue: 0.51).opacity(0.6), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            } else {
                Color.tibbyBaseWhite
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.97, green: 0.96, blue: 0.94).opacity(0.6), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.68, green: 0.67, blue: 0.65).opacity(0.6), location: 0.73),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            }
            
        }
        .ignoresSafeArea(.all)
        
    }
}


#Preview {
    StreakView()
}
