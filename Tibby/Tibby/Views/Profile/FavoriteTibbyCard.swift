//
//  FavoriteTibbyCard.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 13/09/24.
//

import SwiftUI

struct FavoriteTibbyCard: View {
    @State var name: String
    var color: Color
    var image: String
    var rarity: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("Capsule\(rarity)")
                    .resizable()
                    .frame(width: 15, height: 15)
                Spacer()
            }
            
            HStack(alignment: .center) {
                Image(image)
                    .resizable()
                    .scaleEffect(1.5)
                    .scaledToFit()
            }
            .padding(.bottom, 5)
            HStack {
                Text(name)
                    .font(.typography(.label2))
                    .padding(.vertical, 4)
                    .frame(width: 90)
                    .foregroundStyle(Color.tibbyBaseBlack)
            }
            .background(Color.tibbyBaseWhite.opacity(0.5))
            .withBorderRadius(20)
        }
        .padding(8)
        .aspectRatio(1, contentMode: .fit)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(color)
        }
        .shadow(color: Color(red: 0.16, green: 0.17, blue: 0.22).opacity(0.2), radius: 2, x: 0, y: 0)
    }
}

