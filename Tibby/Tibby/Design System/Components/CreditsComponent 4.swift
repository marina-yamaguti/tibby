//
//  CreditsComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 26/08/24.
//

import SwiftUI

struct CreditsComponent: View {
    let designers: [String] = ["Mateus Moura Godinho", "Marina Geller Yamaguti"]
    let developers: [String] = ["Felipe Elsner da Silva", "Maria Eduarda Maciel", "Marina Geller Yamaguti", "Natália Dal Pizzol", "Sofia Sartori"]
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Credits")
                .font(.typography(.title))
            Text("Design")
                .font(.typography(.label2))
                .foregroundStyle(.tibbyBaseBlack)
            ForEach(designers, id: \.self) { designer in
                Text(designer)
                    .font(.typography(.body2))
            }
            Text("Development")
                .font(.typography(.label2))
                .foregroundStyle(.tibbyBaseBlack)
            ForEach(developers, id: \.self) { dev in
                Text(dev)
                    .font(.typography(.body2))
            }
            .foregroundStyle(.tibbyBaseBlack)
        }
        .padding(.top, 16)
    }
}

#Preview {
    CreditsComponent()
}
