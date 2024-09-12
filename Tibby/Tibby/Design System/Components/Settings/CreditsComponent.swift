//
//  CreditsComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 26/08/24.
//

import SwiftUI

struct CreditsComponent: View {
    let designers: [String] = ["Mateus Moura Godinho", "Marina Geller Yamaguti"]
    let developers: [String] = ["Felipe Elsner da Silva", "Maria Eduarda Maciel", "Marina Geller Yamaguti", "Natália Dal Pizzol", "Sofia Sartori"]
    var body: some View {
        VStack {
            PageHeader(title: "Credits", symbol: TibbySymbols.starListBlack.rawValue)
            
            VStack(spacing: 16){
                Image("TibbyLogoFull")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                
                Text("Brought to you by:")
                    .font(.typography(.label))
                    .foregroundStyle(.tibbyBaseBlack)

                Text("Development")
                    .font(.typography(.headline))
                    .foregroundStyle(.tibbyBaseRed)
                    .padding(.bottom, 32)

                ForEach(developers, id: \.self) { developer in
                    Text(developer)
                        .font(.typography(.title))
                        .foregroundStyle(.tibbyBaseBlack)
                }

                Text("Design")
                    .font(.typography(.headline))
                    .foregroundStyle(.tibbyBaseRed)
                    .padding(32)
                ForEach(developers, id: \.self) { developer in
                    Text(developer)
                        .font(.typography(.title))
                        .foregroundStyle(.tibbyBaseBlack)
                }
                
            }
            .padding()
        }
        .ignoresSafeArea()
        .background(.tibbyBaseWhite)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreditsComponent()
}
