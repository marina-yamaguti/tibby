//
//  ProgressIndicator.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/08/24.
//

import SwiftUI

/// A view that displays a multi-color progress indicator using capsules.
///
/// `ProgressIndicator` visually represents the current progress across multiple steps using colored capsules.
/// The indicator changes color based on the current page, making it easy to see which steps are complete and which are pending.
struct ProgressIndicator: View {
    
    /// The current page or step that the user is on. This value determines which capsules are filled with color and which remain black.
    var page: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<5, id: \.self) { index in
                Capsule()
                    .fill(page < index ? .black.opacity(0.5) : .tibbyBaseGreen)
                    .aspectRatio(6, contentMode: .fit)
            }
        }
    }
}
