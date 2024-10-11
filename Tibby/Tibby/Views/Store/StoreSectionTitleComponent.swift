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
    
    init(title: String, backgrounImage: String) {
        self.title = title
        self.backgrounImage = backgrounImage
    }
    
    var body: some View {
        ZStack {
            Image(backgrounImage)
                .resizable()
            
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

