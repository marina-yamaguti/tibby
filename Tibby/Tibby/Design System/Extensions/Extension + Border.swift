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
    func withBorderRadius(_ radius: CGFloat) -> some View {
        self.cornerRadius(radius)
    }
    
    /// Adds a border with a specified color and width to the view
    func withBorder(_ color: Color, width: CGFloat) -> some View {
        self.border(color, width: width)
    }
}
