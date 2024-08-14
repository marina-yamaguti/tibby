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
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 391, height: 300.62421)
                .background(viewModel.color)
                .cornerRadius(20)
            
            VStack {
                TibbyProfileIcon(icon: "\(viewModel.species)1", status: .selected, action: {})
                TibbyNameEdit(name: viewModel.tibby.name)
                HStack {
                    
                    Text("Species: \(viewModel.species)")
                    Text("Rarity: \(viewModel.rarity)")
                }
                .font(.headline)
                .padding()
                TibbyDescriptionLabel(description: viewModel.description, color: viewModel.color)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    TibbySelectedView(viewModel: TibbySelectedViewModel(tibby: Tibby(id: UUID(), name: "Shark", species: "shark", collection: "seaSeries", rarity: "common", description: "Despite his fearsome appearance, Shark loves making new friends and exploring the underwater world. With sharp fins and a swift tail, he can glide through the ocean with grace and agility.", isUnlocked: true, isSelected: true)))
//}
