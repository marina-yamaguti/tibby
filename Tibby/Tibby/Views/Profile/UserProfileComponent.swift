//
//  UserProfileComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/09/24.
//

import SwiftUI

struct UserProfileComponent: View {
    @Binding var currentTibby: Tibby
    @State var user: User
    var currentXp: Int = 30
    var xpToEvolve: Int = 100
    
    var body: some View {
        HStack(alignment: .bottom) {
            Image("\(currentTibby.species)Icon")
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(user.username)
                        .font(.typography(.title))
                        .foregroundStyle(.tibbyBaseBlack)
                    Spacer()
                    Button(action: {}) {
                        ButtonLabel(type: .secondary, image: TibbySymbols.pen.rawValue, text: "")
                    }
                    .buttonSecondary(bgColor: .black.opacity(0.5))
                }
                
                HStack {
                    Text("Tibby:")
                        .font(.typography(.label2))
                        .foregroundStyle(.tibbyBaseGrey)
                    
                    Text(currentTibby.name)
                        .font(.typography(.label))
                        .foregroundStyle(.tibbyBaseBlack)
                }
                
                HStack(alignment: .center) {
                    Text("Lv. \(user.level)")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseBlack)
                    Spacer()
                    Text("\(currentXp)/\(xpToEvolve)")
                        .font(.typography(.label2))
                        .foregroundStyle(.tibbyBaseGrey)
                }
                ProgressView(value: Double(currentXp), total: Double(xpToEvolve))
                    .progressViewStyle(CustomProgressBar(barType: .xp))
            }
        }
        .frame(height: 126)
    }
}
