//
//  Collections.swift
//  Tibby
//
//  Created by Sofia Sartori on 06/08/24.
//

import Foundation
import SwiftUI

enum Collection: String, CaseIterable {
    var description: String {
        switch self {
        case .seaSeries:
            return "small description about the sea series"
        case .forestSeries:
            return ""
        case .beachSeries:
            return ""
        case .houseSeries:
            return ""
        case .foodSeries:
            return ""
        case .urbanSeries:
            return ""
        }
    }
    
    var color: Color {
        switch self {
        case .seaSeries:
            return Color.tibbyBaseBlue
        case .forestSeries:
            return Color.tibbyBaseGreen
        case .beachSeries:
            return Color.tibbyBaseOrange
        case .houseSeries:
            return Color.tibbyBasePink
        case .foodSeries:
            return Color.tibbyBaseWhite
        case .urbanSeries:
            return Color.tibbyBaseGrey
        }
    }
    
    case seaSeries = "Sea Series"
    case houseSeries = "House Series"
    case forestSeries = "Forest Series"
    case beachSeries = "Beach Series"
    case foodSeries = "Food Series"
    case urbanSeries = "Urban Series"
}
