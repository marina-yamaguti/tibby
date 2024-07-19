//
//  CurvedRectangleComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 18/07/24.
//

import SwiftUI

struct CurvedRectangleComponent: View {
    var body: some View {
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 45, bottomTrailing: 45, topTrailing: 0))
                .foregroundStyle(Color.tibbyBaseBlue)
    }
}

#Preview {
    CurvedRectangleComponent()
}
