//
//  TestSelected.swift
//  Tibby
//
//  Created by Marina Yamaguti on 14/08/24.
//

import SwiftUI

struct TestSelected: View {
    var body: some View {
        ZStack {
            ZStack (alignment: .top) {
                Color.tibbyBaseWhite.ignoresSafeArea()
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.tibbyBaseBlue)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
            } .ignoresSafeArea()
            VStack {
                
                //Back Button
                HStack {
                    CustomBackButton()
                    Spacer()
                }
               
                VStack (alignment: .center, spacing: 16){
                    
                    // Tibby Name Edit
                    TibbyNameEdit(name: "Shark")
                    // Tibby Profile Icon
                    TibbyProfileIcon(icon: "shark1Icon", status: .selected, action: {})
                }
                .padding(.bottom, 40)
                ScrollView {
                    VStack (alignment: .leading, spacing: 16) {
                        // Tibby Info Labels
                        HStack(spacing: 32) {
                            TibbySpeciesLabel(species: "shark", color: Color.tibbyBaseBlue)
                            TibbyRarityLabel(rarity: .common, color: Color.tibbyBaseBlue)
                        }
                        
                        // Tibby Description
                        TibbyDescriptionLabel(description: "Despite his fearsome appearance, Shark loves making new friends and exploring the underwater world. With sharp fins and a swift tail, he can glide through the ocean with grace and agility.", color: Color.tibbyBaseBlue)
                    }
                } .scrollIndicators(.hidden)
            }
            .padding()
            .padding(.horizontal, 16)
        }
        .background(Color.tibbyBaseWhite)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TestSelected()
}
