//
//  Extension + Shadow.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 11/10/24.
//

import SwiftUI

struct CustomShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(red: 0.16, green: 0.17, blue: 0.22).opacity(0.2), radius: 2, x: 0, y: 0)
    }
}

extension View {
    func customShadow() -> some View {
        self.modifier(CustomShadowModifier())
    }
}
