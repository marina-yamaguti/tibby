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
    func buttonSecondary(isDisabled: Bool? = false) -> some View {
        self.buttonStyle(ButtonSecondary())
    }
    
//    func buttonRound(isDisabled: Bool? = false) -> some View {
//        self.buttonStyle(RoundButton())
//    }
}