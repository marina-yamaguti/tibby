//
//  StreakComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 02/09/24.
//

import SwiftUI

import SwiftUI

struct StreakScroll: View {
    @ObservedObject var streak: GameStreak
    @EnvironmentObject var dateManager: DateManager
    let today = Date()
    
    // Get the dates around today (past 15 days and next 15 days)
    var next30Days: [(date: Date, dayName: String)] {
        dateManager.get15DaysPastAndFuture(from: today)
    }
    
    // Fetch streak dates by checking the streak record
    var streakDates: [Date] {
        calculateStreakDays()
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(next30Days, id: \.date) { day in
                        // Determine if the day falls within the streak period based on the record
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
    }
    
    private func calculateStreakDays() -> [Date] {
        var streakDays: [Date] = []
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        for day in next30Days {
            let dateString = formatter.string(from: day.date)
            // Check if the day exists in the streak record
            if let isStreakOn = streak.streakRecord[dateString] {
                if isStreakOn {
                    streakDays.append(day.date)
                }
            } else {
                // If there's no record for this day, mark it as a missed streak
                streak.streakRecord[dateString] = false
            }
        }
        
        return streakDays
    }
    
}

struct StreakScroll_Previews: PreviewProvider {
    static var previews: some View {
        StreakScroll(streak: GameStreak())
    }
}


import SwiftUI

struct StreakDays: View {
    @ObservedObject var streak: GameStreak
    var date: Date
    var dayName: String
    var isToday: Bool
    var isPartOfStreak: Bool
    let today = Date()
    var isPastDay: Bool {
        date < today && !isToday
    }
    var isFutureDay: Bool {
        date > today
    }
    
    var body: some View {
        VStack {
            // Determine the capsule to show based on streak status and date
            if isPastDay && isPartOfStreak || isToday && isPartOfStreak{
                Image("CapsuleStreakOn")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 22, height: 26)
            } else if isPastDay && !isPartOfStreak {
                // Streak is broken on past day
                Image("broken6")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 22, height: 26)
            } else {
                // Default to neutral for any remaining cases
                Image("CapsuleStreakOff")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 22, height: 26)
            }

            // Day number
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.typography(.body))
                .kerning(0.25)
                .foregroundStyle(isToday ? .tibbyBaseDarkBlue : (isPartOfStreak ? .tibbyBaseDarkBlue : .tibbyBaseWhite))
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(isToday ? .tibbyBaseWhite : (isPartOfStreak ? .tibbyBaseWhite : .tibbyBaseDarkBlue))
                }

            // Day name (abbreviated)
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

    /// Check if today's streak is neither broken nor started, making it a "common/neutral" capsule.
    private func todayStatus() -> Bool {
        let todayString = dateToString(today)
        return streak.streakRecord[todayString] == nil
    }
    
    /// Helper method to convert a `Date` to a string in "yyyy-MM-dd" format.
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
