//
//  CollectionNameComponent.swift
//  Tibby
//
//  Created by Sofia Sartori on 19/08/24.
//

import SwiftUI

struct CollectionNameComponent: View {
    var name: String
    var color: Color
    var body: some View {
        Text(name)
            .font(.typography(.title))
            .foregroundStyle(Color.tibbyBaseBlack)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
    }
}

#Preview {
    CollectionNameComponent(name: "Sea Series", color: Color.tibbyBaseBlue)
}
