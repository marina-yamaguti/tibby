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
                    EquipComponent(viewModel: viewModel, isSelected: $viewModel.status)
                    Button(action: {viewModel.toggleFavorite()}, label: {ButtonLabel(type: .secondary, image: viewModel.isFavorite ? TibbySymbols.heartFill.rawValue : TibbySymbols.heart.rawValue , text: "")})
                        .buttonSecondary(bgColor: viewModel.isFavorite ? .tibbyBaseSaturatedGreen : .black.opacity(0.5))
                }
                .padding(.bottom, 24)
                VStack (alignment: .center, spacing: 16){
                    
                    // MARK: - Tibby Name Edit
                    TibbyNameEdit(tibby: $viewModel.tibby)
                        .padding(8)
                        .background(Color.tibbyBaseWhite.opacity(0.5))
                        .withBorderRadius(40)
                    TibbyStatusComponent(hunger: viewModel.tibby.hunger, sleep: viewModel.tibby.sleep, play: viewModel.tibby.happiness)
                        .frame(width: 145, alignment: .center)
                    
                    // MARK: - Tibby Profile Icon
                    TibbyProfileIcon(icon: "\(viewModel.tibby.species)Icon", status: $viewModel.status) {
                        viewModel.changeTibby()
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
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Limit Reached"),
                    message: Text("You reached the limit of favourite Tibbies (3). Remove one to add another."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .background(Color.tibbyBaseWhite)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all, edges: Edge.Set(.bottom))
    }
}
