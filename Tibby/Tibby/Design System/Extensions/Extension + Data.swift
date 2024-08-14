//
//  Extension + Data.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 08/08/24.
//

import Foundation

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    static var startOfWeek: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        components.weekday = 1
        
        return calendar.date(from: components)!
    }
}

enum DataType {
    case day, week
}
