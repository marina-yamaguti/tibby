//
//  StreakComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 02/09/24.
//

import SwiftUI


import SwiftUI

struct StreakScroll: View {
    @State var streak: GameStreak
    @ObservedObject var dateManager = DateManager()
    let today = Date()

    var body: some View {
        let daysInMonth = dateManager.getAllDaysInMonth(for: today)

        // Use ScrollViewReader to enable programmatically scrolling to the current day
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(daysInMonth, id: \.date) { day in
                        StreakDays(
                            streak: streak,
                            date: day.date,
                            dayName: day.dayName,
                            isToday: Calendar.current.isDateInToday(day.date)
                        )
                        .id(day.date) // Assign a unique ID to each day
                    }
                }
                .padding(.horizontal)
                .onAppear {
                    // Scroll to today's date when the view appears
                    if let today = daysInMonth.first(where: { Calendar.current.isDateInToday($0.date) }) {
                        proxy.scrollTo(today.date, anchor: .leading)
                    }
                }
            }
        }
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
    
    var body: some View {
        VStack {
            // Image indicating streak
            Image(streak.currentStreak > 0 ? "CapsuleStreakOn" : "CapsuleStreakOff")
                .resizable()
                .scaledToFill()
                .frame(width: 22, height: 26)
            
            // Display the day number
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.typography(.body))
                .kerning(0.25)
                .foregroundStyle(isToday ? .tibbyBaseDarkBlue : (streak.currentStreak > 0 ? .tibbyBaseDarkBlue : .tibbyBaseWhite))
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(isToday ? .tibbyBaseWhite : (streak.currentStreak > 0 ? .tibbyBaseWhite : .tibbyBaseDarkBlue))
                }
            
            // Display the abbreviated day name
            Text(dayName)
                .font(.typography(.label2))
                .foregroundStyle(isToday ? .tibbyBaseWhite : (streak.currentStreak > 0 ? .tibbyBaseWhite : .tibbyBaseDarkBlue))
                .frame(width: 40)
                .minimumScaleFactor(0.5)  // Allow text to shrink if needed
                .lineLimit(1)  // Prevents multi-line text
        }
        .frame(width: 65, height: 110)
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(isToday ? .tibbyBaseDarkBlue : (streak.currentStreak > 0  ? .tibbyBaseDarkBlue : .clear))
                .stroke(isToday ? .clear : .tibbyBaseDarkBlue, lineWidth: streak.currentStreak > 0 ? 0 : 1)
        }
        .padding(4)
    }
}
