//
//  Collections.swift
//  Tibby
//
//  Created by Sofia Sartori on 06/08/24.
//

import Foundation
import SwiftUI

/// The `Collection` enum represents various themed series of Tibbies.
///
/// Each case in this enum corresponds to a different series of Tibbies, with associated descriptions and colors.
enum Collection: String, CaseIterable {
    
    /// A description of the collection.
    var description: String {
        switch self {
        case .seaSeries:
            return "Tibbies found in the deepest oceans"
        case .forestSeries:
            return "Tibbies protected by Mother Nature herself"
        case .beachSeries:
            return "Tibbies who love riding the waves and relaxing under the sun"
        case .houseSeries:
            return "Cute Tibbies who love a good couch or bed"
        case .foodSeries:
            return "Fresh Tibbies waiting for your attention"
        case .urbanSeries:
            return "Tibbies who live in the vast concrete jungles"
        }
    }
    
    /// The color associated with the collection.
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