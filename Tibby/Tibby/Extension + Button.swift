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
    
    func buttonNavigation(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonNavigation())
    }
}
