//
//  Extension + Button.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/07/24.
//

import Foundation
import SwiftUI

extension Button {
    /// Applies the primary button style to the view.
    ///
    /// This modifier applies a custom primary button style to the view, using the specified background color.
    ///
    /// - Parameters:
    ///   - bgColor: The background color for the primary button.
    ///   - isDisabled: A Boolean value that indicates whether the button is disabled. The default is `false`.
    /// - Returns: A view with the primary button style applied.
    func buttonPrimary(bgColor: Color, isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonPrimary(bgColor: bgColor))
    }
    
    /// Applies the secondary button style to the view.
    ///
    /// This modifier applies a custom secondary button style to the view, using the specified background color.
    ///
    /// - Parameters:
    ///   - isDisabled: A Boolean value that indicates whether the button is disabled. The default is `false`.
    ///   - bgColor: The background color for the secondary button.
    /// - Returns: A view with the secondary button style applied.
    func buttonSecondary(isDisabled: Bool? = false, bgColor: Color) -> some View {
        self.buttonStyle(ButtonSecondary(bgColor: bgColor))
    }
    
    /// Applies the tertiary button style to the view.
    ///
    /// This modifier applies a custom tertiary button style to the view.
    ///
    /// - Parameter isDisabled: A Boolean value that indicates whether the button is disabled. The default is `false`.
    /// - Returns: A view with the tertiary button style applied.
    func buttonTertiary(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonTertiary())
    }
    
    /// Applies the tab bar button style to the view.
    ///
    /// This modifier applies a custom tab bar button style to the view.
    ///
    /// - Parameter isDisabled: A Boolean value that indicates whether the button is disabled. The default is `false`.
    /// - Returns: A view with the tab bar button style applied.
    func buttonTabBar(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(TabBarButton())
    }
    
}
