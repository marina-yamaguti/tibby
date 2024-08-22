//
//  Extension + Data.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 08/08/24.
//

import Foundation

extension Date {
    /// Returns the date representing the start of the current day.
    ///
    /// - Returns: A `Date` object set to the start of the current day.
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    /// Returns the date representing the start of the current week.
    ///
    /// - Returns: A `Date` object set to the start of the current week.
    static var startOfWeek: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        components.weekday = 1 // Set the weekday to Sunday
        
        return calendar.date(from: components)!
    }
}

enum DateType {
    case day, week
}
