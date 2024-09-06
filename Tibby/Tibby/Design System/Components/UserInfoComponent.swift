//
//  UserInfoComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 05/09/24.
//

import SwiftUI

struct UserInfoComponent: View {
    var profileImage: String
    var userName: String
    var tibbyName: String
    var level: Int
    var currentXp: Int
    var xpToEvolve: Int

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center) {
//                    Image(profileImage)
//                        .resizable()
                RoundedRectangle(cornerRadius: 20)
                        .frame(width: 110, height: 110)
//                        .cornerRadius(20)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(userName)
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
                        
                        Text(tibbyName)
                            .font(.typography(.label))
                            .foregroundStyle(.tibbyBaseBlack)
                        
                    }
                    HStack(alignment: .center) {
                        Text("Lv. \(level)")
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
        }
    }
}


