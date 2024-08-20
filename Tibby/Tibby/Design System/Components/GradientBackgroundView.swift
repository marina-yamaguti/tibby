//
//  GradientBackgroundView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/08/24.
//

import SwiftUI

/// A view that displays a linear gradient background with rounded corners.
struct GradientBackgroundView: View {
    /// The corner radius applied to the view's edges.
    var cornerRadius: CGFloat
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.white.opacity(0.3),  // Light at the start
                Color.clear,               // Transparent in the middle
                Color.black.opacity(0.3)   // Dark at the end
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .cornerRadius(cornerRadius)  // Apply the specified corner radius
    }
}
