//
//  StreakAnimation.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 19/09/24.
//

import SwiftUI

struct StreakView: View {
    @State var streak = GameStreak()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dateManager: DateManager
    let today = Date()
    var next30Days: [(date: Date, dayName: String)] {
        dateManager.get15DaysPastAndFuture(from: today)
    }
    // Calculate the start of the streak period (counting backwards from today)

    var streakDates: [Date] {
        calculateStreakDays()
    }
    
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
            
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(next30Days, id: \.date) { day in
                            // Determine if the day falls within the streak period
                            let isPartOfStreak = streakDates.contains { Calendar.current.isDate($0, inSameDayAs: day.date) }
                            
                            StreakDays(
                                streak: streak,
                                date: day.date,
                                dayName: day.dayName,
                                isToday: Calendar.current.isDateInToday(day.date),
                                isPartOfStreak: isPartOfStreak
                            )
                            .id(day.date)
                        }
                    }
                    .scrollTargetLayout()
                    .padding(.horizontal)
                    .onAppear {
                        if let today = next30Days.first(where: { Calendar.current.isDateInToday($0.date) }) {
                            // Scroll to today and align it to the leading position
                            DispatchQueue.main.async {
                                proxy.scrollTo(today.date, anchor: .leading)
                            }
                        }
                    }
                }
                .scrollTargetBehavior(.viewAligned)
            }
            
            
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
    private func calculateStreakDays() -> [Date] {
        guard streak.currentStreak > 0, let lastUpdated = streak.lastUpdated else {
            return []
        }
        
        var streakDates: [Date] = []
        let calendar = Calendar.current
        
        // Calculate the streak dates by going back from lastUpdated day by the number of streak days
        for offset in 0..<streak.currentStreak {
            if let date = calendar.date(byAdding: .day, value: -offset, to: lastUpdated) {
                streakDates.append(date)
            }
        }
        return streakDates
    }
}


#Preview {
    StreakView()
}
