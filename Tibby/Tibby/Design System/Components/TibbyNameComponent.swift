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
                .font(.typography(.body))
                .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
                .foregroundStyle(Color.tibbyBaseBlack)
        }
        .background(Color.tibbyBaseWhite.opacity(0.5))
        .withBorderRadius(20)
    }
}

#Preview {
    TibbyNameComponent(name: "Everton")
}
