//
//  CreditsComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 26/08/24.
//

import SwiftUI

struct CreditsComponent: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Credits")
                    .font(.typography(.title))
                    .foregroundStyle(.tibbyBaseBlack)
                VStack(alignment: .leading) {
                    Text("Design")
                        .font(.typography(.label2))
                        .foregroundStyle(.tibbyBaseBlack)
                    Text("Mateus Moura Godinho")
                        .font(.typography(.body2))
                        .foregroundStyle(.tibbyBaseBlack)
                    Text("Marina Geller Yamaguti")
                        .font(.typography(.body2))
                        .foregroundStyle(.tibbyBaseBlack)

                }
                VStack(alignment: .leading) {
                    Text("Development")
                        .font(.typography(.label2))
                        .foregroundStyle(.tibbyBaseBlack)
                    Text("Felipe Elsner da Silva")
                        .font(.typography(.body2))
                        .foregroundStyle(.tibbyBaseBlack)
                    Text("Maria Eduarda Maciel")
                        .font(.typography(.body2))
                        .foregroundStyle(.tibbyBaseBlack)
                    Text("Marina Geller Yamaguti")
                        .font(.typography(.body2))
                        .foregroundStyle(.tibbyBaseBlack)
                    Text("Natália Dal Pizzol")
                        .font(.typography(.body2))
                        .foregroundStyle(.tibbyBaseBlack)
                    Text("Sofia Sartori")
                        .font(.typography(.body2))
                        .foregroundStyle(.tibbyBaseBlack)
                }
            }
            .foregroundStyle(Color.tibbyBasePearlBlue)
            Spacer()
        }
        .padding(.top, 16)
    }
}

#Preview {
    CreditsComponent()
}
