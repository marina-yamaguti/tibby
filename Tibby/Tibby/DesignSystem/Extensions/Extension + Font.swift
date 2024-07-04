//
//  Extension + Font.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 02/07/24.
//

import SwiftUI

extension Font {
    public static func fontStyle(_ type: FontStyle) -> Font {
        return .custom(type.fontName, size: type.size, relativeTo: type.relativeTo)
    }
}
