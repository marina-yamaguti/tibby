//
//  StreakComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 02/09/24.
//

import SwiftUI

struct StreakScroll: View {
    @State var streak: GameStreak
    @ObservedObject var dateManager = DateManager()
    let today = Date()

    var body: some View {
        // Get the dates around today (past 15 days and next 15 days)
        let next30Days = dateManager.get15DaysPastAndFuture(from: today)
        
        // Calculate the start of the streak period (counting backwards from today)
        let streakDates = calculateStreakDays()

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
                        DispatchQueue.main.async {
                            proxy.scrollTo(today.date, anchor: .center)
                        }
                    }
                }
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }

    /// Calculate the streak days by counting backwards from today based on the current streak length.
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


struct StreakScroll_Previews: PreviewProvider {
    static var previews: some View {
        StreakScroll(streak: GameStreak())
    }
}


struct StreakDays: View {
    @State var streak: GameStreak
    var date: Date
    var dayName: String
    var isToday: Bool
    var isPartOfStreak: Bool // New property to track if the day is part of the streak
    
    var body: some View {
        let isPastDay = date < Date() && !isToday // Check if the day is in the past
        
        VStack {
            // Image indicating if the day is part of the streak
            Image(isPartOfStreak ? "CapsuleStreakOn" : "CapsuleStreakOff")
                .resizable()
                .scaledToFill()
                .frame(width: 22, height: 26)
            
            // Display the day number
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.typography(.body))
                .kerning(0.25)
                .foregroundStyle(isToday ? .tibbyBaseDarkBlue : (isPartOfStreak ? .tibbyBaseDarkBlue : .tibbyBaseWhite))
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(isToday ? .tibbyBaseWhite : (isPartOfStreak ? .tibbyBaseWhite : .tibbyBaseDarkBlue))
                }
            
            // Display the abbreviated day name
            Text(dayName)
                .font(.typography(.label2))
                .foregroundStyle(isToday ? .tibbyBaseWhite : (isPartOfStreak ? .tibbyBaseWhite : .tibbyBaseDarkBlue))
                .frame(width: 40)
                .minimumScaleFactor(0.5)  // Allow text to shrink if needed
                .lineLimit(1)  // Prevents multi-line text
        }
        .frame(width: 65, height: 110)
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(isToday ? .tibbyBaseDarkBlue : (isPartOfStreak ? .tibbyBaseDarkBlue : .clear))
                .stroke(isToday ? .clear : .tibbyBaseDarkBlue, lineWidth: isPartOfStreak ? 0 : 1)
        }
        .padding(4)
        .opacity(isPastDay ? 0.5 : 1.0) // Apply 50% opacity to past days
    }
}
