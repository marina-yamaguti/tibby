//
//  EquipComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 30/08/24.
//

import SwiftUI

struct EquipComponent: View {
    @Binding var isSelected: SelectionStatus

    var body: some View {
        HStack(spacing: 16) {
            Text(isSelected == .selected ? "Equipped" : "Equip")
                .font(.typography(.body))
                .foregroundStyle(isSelected == .selected ? .tibbyBaseGrey : .tibbyBaseBlack)
            if isSelected == .unselected {
                Image(TibbySymbols.checkmarkWhite.rawValue)
                    .frame(width: 14, height: 14)
                    .padding(12)
                    .background {
                        Circle()
                            .fill(.black.opacity(0.5))
                    }
            }
        }
        .contentShape(Rectangle()) // This ensures the whole area is tappable
        .onTapGesture {
            toggleSelection()
        }
    }

    private func toggleSelection() {
        isSelected = (isSelected == .selected) ? .unselected : .selected
    }
}
