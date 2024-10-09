//
//  StoreSectionTitle.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/10/24.
//

import SwiftUI

struct StoreSectionTitleComponent: View {
    private var title: String
    private var backgrounImage: String
    private var color: Color
    
    init(title: String, backgrounImage: String, color: Color) {
        self.title = title
        self.backgrounImage = backgrounImage
        self.color = color
    }
    
    var body: some View {
        ZStack {
            Image(backgrounImage)
                .resizable()
            
            color
                .opacity(0.8)
            
            HStack {
                Text(title)
                    .font(.typography(.title))
                    .foregroundStyle(.tibbyBaseBlack)
                    .kerning(0.15)
                    .padding(.leading, 15)
                Spacer()
                
            }
        }
        .frame(maxWidth: .infinity, idealHeight: 90)
    }
}

