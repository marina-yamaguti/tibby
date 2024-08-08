//
//  Extension + Button.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/07/24.
//

import Foundation
import SwiftUI

extension Button {
    func buttonPrimary(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonPrimary())
    }
    func navigationButton(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(NavigationButton())
    }
    func tabBarButton() -> some View {
        self.buttonStyle(TabBarButton())
    }
}
