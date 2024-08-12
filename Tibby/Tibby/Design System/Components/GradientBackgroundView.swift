//
//  GradientBackgroundView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/08/24.
//

import SwiftUI

struct GradientBackgroundView: View {
    var bgColor: Color
    var cornerRadius: CGFloat
    var body: some View {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.white.opacity(0.3), location: 0.00),
                    .init(color: Color(red: 0.53, green: 0.53, blue: 0.53).opacity(0), location: 0.50),
                    .init(color: Color.black.opacity(0.3), location: 1.00)
                ]),
                startPoint: .init(x: 0, y: 0.5),
                endPoint: .init(x: 1, y: 0.5)
            )
        .withBorderRadius(cornerRadius)
    }
}

#Preview {
    GradientBackgroundView(bgColor: .tibbyBaseBlue, cornerRadius: 50)
}
