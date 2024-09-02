//
//  TibbyDetailsLabel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 08/08/24.
//

//
//  TibbyDetailsLabel.swift
//  Tibby
//
//  Created by Marina Yamaguti on 08/08/24.
//

import SwiftUI

/// A view that displays a labeled representation of a Tibby species.
///
/// `TibbySpeciesLabel` shows the species name alongside a colored circle, with a styled background matching the species color.
struct TibbySpeciesLabel: View {
    /// The species name to display.
    @State var species: String
    
    /// The color associated with the species.
    @State var color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Label for the species category
            Text("species")
                .font(.typography(.body2))
                .foregroundStyle(Color.tibbyBaseBlack)
            
            HStack(spacing: 4) {
                // Colored circle representing the species color
                Circle()
                    .frame(width: 27, height: 27)
                    .foregroundColor(color)
                    .saturation(2.0)
                    .brightness(-0.1)
                
                // Species name
                Text(species)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .font(.typography(.label))
                    .foregroundStyle(Color.tibbyBaseBlack)
            }
            .padding()
            .background(
                Rectangle()
                    .fill(color)
                    .cornerRadius(20)
            )
        }
    }
}

#Preview {
    TibbySpeciesLabel(species: "Shark", color: .tibbyBaseBlue)
}
