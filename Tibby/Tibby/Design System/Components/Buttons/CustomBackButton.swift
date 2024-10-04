//
//  CustomBackButton.swift
//  Tibby
//
//  Created by Sofia Sartori on 09/08/24.
//

import SwiftUI

/// A custom back button view used to navigate back to the previous screen.
/// This view uses the environment's `presentationMode` to dismiss the current view when tapped.
struct CustomBackButton: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var constants: Constants
    
    var body: some View {
        Button(action: {
            HapticManager.instance.impact(style: .soft)
            dismiss()
        }, label: {
            ButtonLabel(type: .secondary, image: TibbySymbols.chevronLeftWhite.rawValue, text: "")
        })
        .buttonSecondary(bgColor: .black.opacity(0.5))
    }
}
