//
//  EquipComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 30/08/24.
//

import SwiftUI

struct EquipComponent: View {
    @ObservedObject var viewModel: TibbySelectedViewModel
    @Binding var isSelected: SelectionStatus
    @EnvironmentObject var constants: Constants
    
    var body: some View {
        HStack(spacing: 16) {
            Text(isSelected == .selected ? "Equipped" : "Equip")
                .font(.typography(.body))
                .foregroundStyle(isSelected == .selected ? .tibbyBaseGrey : .tibbyBaseBlack)
            Image(TibbySymbols.checkmarkWhite.rawValue)
                .resizable()
                .frame(width: 14, height: 14)
                .padding(14)
                .background {
                    Circle()
                        .fill(isSelected == .selected ? .tibbyBaseGrey : .black.opacity(0.5))
                }
            
        }
        .contentShape(Rectangle()) // This ensures the whole area is tappable
        .onTapGesture {
            if isSelected == .unselected {
                isSelected = .selected
                viewModel.changeTibby()
                constants.tibbySleeping = false
                AudioManager.instance.playMusic(audio: .happy)
            }
        }
    }
    
    private func toggleSelection() {
        isSelected = (isSelected == .selected) ? .unselected : .selected
    }
}
