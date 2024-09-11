//
//  ProfileView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 02/09/24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var currentTibby: Tibby
    @State var userName: String = UserDefaults.standard.value(forKey: "username") as? String ?? ""
    var level: Int = 32
    var currentXp: Int = 30
    var xpToEvolve: Int = 100
    var body: some View {
        VStack {
            PageHeader(title: "Profile", symbol: TibbySymbols.profileBlack.rawValue)
            
            VStack(spacing: 16) {
                HStack(alignment: .center) {
                    Image("\(currentTibby.species)Icon")
                        .resizable()
                        .frame(width: 105, height: 105)
                        .cornerRadius(20)
                    
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
                            
                            Text(currentTibby.name)
                                .font(.typography(.label))
                                .foregroundStyle(.tibbyBaseBlack)
                            
                        }
                        HStack(alignment: .center) {
                            Text("Lv. \(level)")
                                .font(.typography(.body))
                                .foregroundStyle(.tibbyBaseBlack)
                            Text("\(currentXp)/\(xpToEvolve)")
                                .font(.typography(.label2))
                                .foregroundStyle(.tibbyBaseGrey)
                        }
                        ProgressView(value: Double(currentXp), total: Double(xpToEvolve))
                            .progressViewStyle(CustomProgressBar(barType: .xp))
                    }
                    
                }
                .padding(.vertical)
                
                Rectangle()
                    .fill(.tibbyBasePearlBlue)
                    .frame(height: 5)
                
                VStack {
                    Text("Showcase")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseBlack)
                }
                .padding(16)
                VStack {
                    Text("My Goals")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseBlack)
                }
                VStack {
                    Text("My Goals")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseBlack)
                    
                }
            }
        }
        
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}


