//
//  Extension + Border.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 04/07/24.
//

import Foundation
import SwiftUI


extension View {
    /// Adds a border radius to the view
    /// 
    /// - Parameter radius: The radius, in points, to use when drawing rounded corners
    /// - Returns: A view that has a rounded corner radius applied.
    func withBorderRadius(_ radius: CGFloat) -> some View {
        self.cornerRadius(radius)
    }
    
    /// Adds a border with a specified color and width to the view
    /// - Parameters:
    ///   - color: The color of the border.
    ///   - width: The width of the border, in points.
    /// - Returns:  A view that has a border with the specified color and width applied.
    func withBorder(_ color: Color, width: CGFloat) -> some View {
        self.border(color, width: width)
    }
}
