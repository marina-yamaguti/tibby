//
//  GoalsComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 02/09/24.
//

import SwiftUI

struct GoalsComponent: View {
//    @Binding 
    var value: Int
    
    /// The title displayed above the component.
    var title: String
    
    /// A description displayed below the value, providing context for what the value represents.
    var description: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.typography(.label2))
            
            Text("\(value)")
                .font(.typography(.body))
            
            Text(description)
                .font(.typography(.body2))
                .foregroundStyle(.tibbyBaseGrey)
        }
        .padding(8)
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.tibbyBaseBlack, lineWidth: 1)
        }

        
    }
}

#Preview {
    GoalsComponent(value: 30, title: "Daily Exercise", description: "minutes/day")
}
