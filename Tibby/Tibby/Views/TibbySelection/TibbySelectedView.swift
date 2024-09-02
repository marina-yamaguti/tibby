//
//  TibbySelectedView.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

struct TibbySelectedView: View {
    @ObservedObject var viewModel: TibbySelectedViewModel
    @EnvironmentObject var constants: Constants
#warning("Aqui deve ser um binding assim que a lógica estiver pronta")
    @State var isFavorite: Bool = false
    
    var body: some View {
        ZStack {
            ZStack (alignment: .top) {
                Color.tibbyBaseWhite.ignoresSafeArea()
                RoundedRectangle(cornerRadius: 20)
                    .fill(viewModel.color)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
            } 
            .ignoresSafeArea()
            VStack {
                //Back Button
                HStack {
                    CustomBackButton()
                    Spacer()
                    EquipComponent(isSelected: $viewModel.status)
                    Button(action: {isFavorite.toggle()}, label: {ButtonLabel(type: .secondary, image: isFavorite ? TibbySymbols.heartFill.rawValue : TibbySymbols.heart.rawValue , text: "")})
                        .buttonSecondary(bgColor: isFavorite ? .tibbyBaseSaturatedGreen : .black.opacity(0.5))
                }
                .padding(.bottom, 24)
                VStack (alignment: .center, spacing: 16){
                    
                    // MARK: - Tibby Name Edit
                    TibbyNameEdit(tibby: $viewModel.tibby)
                    TibbyStatusComponent(hunger: viewModel.tibby.hunger, sleep: viewModel.tibby.sleep, play: viewModel.tibby.happiness)
                        .frame(width: 145, alignment: .center)
                    
                    // MARK: - Tibby Profile Icon
                    TibbyProfileIcon(icon: "\(viewModel.tibby.species)Icon", status: $viewModel.status) {
                        viewModel.changeTibby(vibration: constants.vibration)
                    }
                }
                .padding(.bottom, 40)
                ScrollView {
                    VStack (alignment: .leading, spacing: 16) {
                        // MARK: - Tibby info labels
                        HStack() {
                            TibbySpeciesLabel(species: viewModel.convertCamelCaseToSpaces(viewModel.species), color: viewModel.color)
                            Spacer()
                            TibbyRarityLabel(rarity: viewModel.rarity, color:  viewModel.color)
                        }
                        
                        // MARK: - Tibby description
                        TibbyDescriptionLabel(description: viewModel.tibby.details, color: viewModel.color)
                    }
                } .scrollIndicators(.hidden).ignoresSafeArea(.all, edges: Edge.Set(.bottom))
            }
            .padding()
        }
        .background(Color.tibbyBaseWhite)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all, edges: Edge.Set(.bottom))
    }
}
