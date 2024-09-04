//
//  TibbyNameComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 18/07/24.
//

import SwiftUI

struct TibbyNameComponent: View {
    @State var name: String
    var body: some View {
        HStack {
            Text(name)
                .font(.typography(.body2))
                .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                .foregroundStyle(Color.tibbyBaseBlack)
        }
        .background(Color.tibbyBaseWhite.opacity(0.5))
        .withBorderRadius(20)
    }
}

#Preview {
    TibbyNameComponent(name: "Everton")
}
