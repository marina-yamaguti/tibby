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
    case logo
    
    /// The font name associated with the font style.
    var fontName: String {
        switch self {
        case .logo: return "Dogica Pixel"
        }
    }
    
    var fontNameBold: String {
        switch self {
        case .logo: return "Dogica_Pixel_Bold"
        }
    }
    
    /// The size associated with the font style.
    var size: CGFloat {
        switch self {
        case .logo: return 28
        }
    }
    
    /// The text style associated with the font style, used for dynamic scaling.
    var relativeTo: Font.TextStyle {
        switch self {
        case .logo: return .callout
        }
    }
}
