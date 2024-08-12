//
//  Extension + Button.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/07/24.
//

import Foundation
import SwiftUI

extension Button {
    func buttonPrimary(bgColor: Color, isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonPrimary(bgColor: bgColor))
    }
    func buttonSecondary(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonSecondary())
    }
    func buttonTertiary(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonTertiary())
    }
    func buttonTabBar(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(TabBarButton())
    }
    
}
