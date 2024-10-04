//
//  DateManager.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 13/09/24.
//

import Foundation

class DateManager: ObservableObject {
    
    static let instance = DateManager()
    
    init() {}
    
    @Published var lastDayVisited: Date = UserDefaults.standard.value(forKey: "lastDayVisited") as? Date ?? Date.startOfDay
    
    func getDay() -> Date {
        return Date.startOfDay
    }
    
    func getWeek() -> Date {
        return Date.startOfWeek
    }
    
    func changedDayWeek(dateType: DateType, dateCheck: Date) -> Bool {
        let calendar = Calendar.current
        switch dateType {
        case .day:
            return dateCheck != self.getDay()
        case .week:
            let weekDateComponents = calendar.dateComponents([.year, .month, .day], from: self.getWeek())
            let lastDayDateComponents = calendar.dateComponents([.year, .month, .day], from: dateCheck)
            return !((lastDayDateComponents.day! >= weekDateComponents.day!) && (lastDayDateComponents.month! >= weekDateComponents.month!) && (lastDayDateComponents.year! >= weekDateComponents.year!))
        }
    }
    
    func setToday() {
        lastDayVisited = self.getDay()
    }
    
    // Function to get all days and their abbreviated day of the week in a given month
    func getAllDaysInMonth(for date: Date) -> [(date: Date, dayName: String)] {
        var result: [(Date, String)] = []
        
        let calendar = Calendar.current
        // Get the range of days in the given month
        guard let range = calendar.range(of: .day, in: .month, for: date) else {
            return result // Return empty if range cannot be determined
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // Short form of the day (e.g., "Sat", "Sun")
        
        for day in range {
            var components = calendar.dateComponents([.year, .month], from: date)
            components.day = day
            if let fullDate = calendar.date(from: components) {
                let dayName = formatter.string(from: fullDate)
                result.append((fullDate, dayName))
            }
        }
        return result
    }
    
    func get15DaysPastAndFuture(from startDate: Date) -> [(date: Date, dayName: String)] {
           var result: [(Date, String)] = []
           let calendar = Calendar.current
           let formatter = DateFormatter()
           formatter.dateFormat = "E" // Short form of the day (e.g., "Sat", "Sun")

           // Get 15 days in the past
           for offset in -15..<0 {
               if let pastDate = calendar.date(byAdding: .day, value: offset, to: startDate) {
                   let dayName = formatter.string(from: pastDate)
                   result.append((pastDate, dayName))
               }
           }

           // Include today
           let todayName = formatter.string(from: startDate)
           result.append((startDate, todayName))

           // Get 15 days in the future
           for offset in 1...15 {
               if let futureDate = calendar.date(byAdding: .day, value: offset, to: startDate) {
                   let dayName = formatter.string(from: futureDate)
                   result.append((futureDate, dayName))
               }
           }

           return result
       }
}
