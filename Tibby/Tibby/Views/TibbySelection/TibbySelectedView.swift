//
//  TibbySelectedView.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

struct TibbySelectedView: View {
    @ObservedObject var viewModel: TibbySelectedViewModel
    
    var body: some View {
        ZStack {
            ZStack (alignment: .top) {
                Color.tibbyBaseWhite.ignoresSafeArea()
                RoundedRectangle(cornerRadius: 20)
                    .fill(viewModel.color)
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
                    TibbyNameEdit(name: viewModel.tibby.name)
                    // Tibby Profile Icon
                    TibbyProfileIcon(icon: "shark1Icon", status: $viewModel.status, action: viewModel.changeTibby)
                }
                .padding(.bottom, 40)
                ScrollView {
                    VStack (alignment: .leading, spacing: 16) {
                        // Tibby Info Labels
                        HStack(spacing: 32) {
                            TibbySpeciesLabel(species: viewModel.species, color: viewModel.color)
                            TibbyRarityLabel(rarity: viewModel.rarity, color:  viewModel.color)
                        }
                        
                        // Tibby Description
                        TibbyDescriptionLabel(description: "Despite his fearsome appearance, Shark loves making new friends and exploring the underwater world. With sharp fins and a swift tail, he can glide through the ocean with grace and agility.", color: viewModel.color)
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

//#Preview {
//    TibbySelectedView(viewModel: TibbySelectedViewModel(tibby: Tibby(id: UUID(), name: "Shark", species: "shark", collection: "seaSeries", rarity: "common", description: "Despite his fearsome appearance, Shark loves making new friends and exploring the underwater world. With sharp fins and a swift tail, he can glide through the ocean with grace and agility.", isUnlocked: true, isSelected: true)))
//}
