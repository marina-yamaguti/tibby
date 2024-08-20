//
//  PageHeader.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import SwiftUI

/// A view that represents a standard page header for the Tibby app.
/// This header includes a custom back button, an icon, and a title.
struct PageHeader: View {
    
    /// The title displayed in the header.
    var title: String
    
    /// The name of the symbol (icon) displayed in the header.
    var symbol: String
    
    var body: some View {
        HStack(spacing: 16) {
            CustomBackButton()
                .padding(.trailing, 16)
            
            Image(symbol)
                .resizable()
                .frame(width: 32, height: 32)
            
            Text(title)
                .font(.typography(.title))
                .foregroundStyle(.tibbyBaseWhite)
            
            Spacer()
        }
        .padding(EdgeInsets(top: 78, leading: 16, bottom: 16, trailing: 16))
        .background {
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 20,
                topTrailingRadius: 0,
                style: .continuous
            )
            .fill(.tibbyBaseBlack)
        }
    }
}
