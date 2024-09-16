//
//  DateManager.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 13/09/24.
//

import Foundation

class DateManager {
    
    static let instance = DateManager()
    
    private init() {}
    
    @Published var lastDayVisited: Date = UserDefaults.standard.value(forKey: "lastDayVisited") as? Date ?? Date.startOfDay
    
    func getDay() -> Date {
        return Date.startOfDay
    }
    
    func getWeek() -> Date {
        return Date.startOfWeek
    }
    
    func changedDayWeek(dateType: DateType) -> Bool {
        let calendar = Calendar.current
        switch dateType {
        case .day:
            return lastDayVisited != self.getDay()
        case .week:
            let weekDateComponents = calendar.dateComponents([.year, .month, .day], from: self.getWeek())
            let lastDayDateComponents = calendar.dateComponents([.year, .month, .day], from: lastDayVisited)
            return !((lastDayDateComponents.day! >= weekDateComponents.day!) && (lastDayDateComponents.month! >= weekDateComponents.month!) && (lastDayDateComponents.year! >= weekDateComponents.year!))
        }
    }
    
    func setToday() {
        lastDayVisited = self.getDay()
    }
}
