//
//  TibbyPicker.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 17/07/24.
//

import SwiftUI

/// A view that represents a selectable item with an image, label, and selection status.
///
/// The `ItemCard` view displays an image along with a label indicating the item's name.
/// The card can be in one of three states: unselected, selected, or locked. The view
/// updates its appearance based on the item's current status.
///
/// - Parameters:
///   - name: The name of the item displayed in the label. This is a binding value to allow two-way data flow.
///   - status: The current selection status of the item, which can be unselected, selected, or locked.
///   - color: The background color used for the label at the bottom of the card.
///   - image: The name of the image resource to display in the item card.
struct ItemCard: View {
    @Binding var name: String
    @State var status: SelectionStatus
    var color: Color
    var image: String
    
    var body: some View {
        ZStack {
            Color.tibbyBaseWhite
                .cornerRadius(15)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(borderColor(for: status), lineWidth: status == .unselected ? 2 : 4)
                }
            
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .brightness(status == .locked ? -1 : 0) // Dim the image if the item is locked
                        .padding(.vertical, 8)
                        .padding(.bottom, 30)
                }
            }
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    ZStack {
                        if status == .locked {
                            statusIcon(backgroundColor: .tibbyBaseGrey, iconName: TibbySymbols.lockBlack.rawValue)
                        } else if status == .selected {
                            statusIcon(backgroundColor: .tibbyBaseGreen, iconName: TibbySymbols.checkmarkBlack.rawValue)
                        }
                    }
                }
                Spacer()
                HStack {
                    Text(status == .locked ? "???" : name)
                        .font(.typography(.label2))
                        .padding(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                        .foregroundColor(.tibbyBaseBlack)
                }
                .background(color)
                .cornerRadius(20)
                .padding(.bottom)
                .padding(.horizontal)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    /// Determines the border color based on the item's status.
    ///
    /// - Parameter status: The current selection status of the item.
    /// - Returns: A `Color` value corresponding to the selection status.
    private func borderColor(for status: SelectionStatus) -> Color {
        switch status {
        case .unselected:
            return .tibbyBaseBlack
        case .selected:
            return .tibbyBaseGreen
        case .locked:
            return .tibbyBaseGrey
        }
    }
    
    /// Creates a status icon for the item based on its selection status.
    ///
    /// - Parameters:
    ///   - backgroundColor: The background color for the status icon.
    ///   - iconName: The name of the image asset to use as the icon.
    /// - Returns: A view representing the status icon.
    private func statusIcon(backgroundColor: Color, iconName: String) -> some View {
        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 14, bottomTrailing: 0, topTrailing: 15))
            .foregroundStyle(backgroundColor)
            .frame(width: 40, height: 30)
            .overlay(
                Image(iconName)
                    .resizable()
                    .frame(width: 15, height: 15)
            )
    }
}
