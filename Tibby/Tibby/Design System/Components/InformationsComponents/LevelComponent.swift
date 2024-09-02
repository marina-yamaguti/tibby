//
//  LevelComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 29/08/24.
//

import SwiftUI

struct LevelComponent: View {
    var level: Int
    var body: some View {
        HStack {
            Image(TibbySymbols.profile.rawValue)
                .frame(width: 14, height: 14)
                .padding(8)
                .background {
                    Circle()
                        .fill(.black.opacity(0.5))

                }
            Text("Lv. \(level)")
                .font(.typography(.body))
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.tibbyBaseWhite.opacity(0.5))
        }
    }
}

#Preview {
    LevelComponent(level: 32)
}
