//
//  Extension + Font.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 02/07/24.
//

import SwiftUI

extension Font {
    /// Returns a custom font based on the provided `FontStyle`.
    ///
    /// This method creates a font using a custom font name, size, and text style defined in the `FontStyle` struct.
    /// - Parameter type:  A `FontStyle` value that specifies the font's name, size, and the text style it is relative to.
    /// - Returns: a custom font based on the provided `FontStyle`.
    public static func typography(_ type: FontStyle) -> Font {
        return .custom(type.fontName, size: type.size, relativeTo: type.relativeTo)
    }
}
