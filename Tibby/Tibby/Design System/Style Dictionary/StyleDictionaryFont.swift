//
//  StyleDictionaryFont.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 02/07/24.
//

import Foundation
import SwiftUI

/// An enumeration representing different font styles used in the app.
public enum FontStyle {
    case display
    case headline
    case body
    case body2
    case label
    case label2
    case title
    
    /// The font name associated with the font style.
    var fontName: String {
        switch self {
        case .display: return "Dogica Pixel"
        case .headline: return "Dogica Pixel"
        case .body: return "Dogica Pixel"
        case .body2: return "Biryani"
        case .label: return "Dogica Pixel"
        case .label2: return "Biryani"
        case .title: return "Dogica Pixel"
        }
    }
    
    /// The size associated with the font style.
    var size: CGFloat {
        switch self {
        case .display: return 45
        case .headline: return 28
        case .body: return 17
        case .body2: return 17
        case .label: return 12
        case .label2: return 12
        case .title: return 20
        }
    }
    
    /// The text style associated with the font style, used for dynamic scaling.
    var relativeTo: Font.TextStyle {
        switch self {
        case .display: return .largeTitle
        case .headline: return .title
        case .body: return .headline
        case .body2: return .headline
        case .label: return .caption
        case .label2: return .caption
        case .title: return .title3
        }
    }
}
