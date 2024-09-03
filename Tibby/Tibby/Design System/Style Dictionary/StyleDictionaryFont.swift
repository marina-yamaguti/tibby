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
    
    /// The font name associated with each font style.
    /// This property returns the name of the font to be used for the respective style.
    var fontName: String {
        switch self {
        case .display, .headline, .body, .label, .title:
            return "Dogica Pixel"  // Primary font used for key styles.
        case .body2, .label2:
            return "Biryani"       // Secondary font used for alternative styles.
        }
    }
    
    /// The size associated with the font style.
    /// This property provides the specific size for the font based on the style.
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
    
    /// The text style associated with each font style, used for dynamic type scaling.
    /// This property returns a `Font.TextStyle` value that determines how the font scales with the user's dynamic type settings, ensuring accessibility.
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
