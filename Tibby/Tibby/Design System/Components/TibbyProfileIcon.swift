//
//  TibbyProfileIcon.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

/// A SwiftUI view that represents a profile icon in the Tibby app.
/// The icon displays different visual states based on the user's selection status.
struct TibbyProfileIcon: View {
    
    /// The name of the image asset to be used for the icon.
    @State var icon: String
    
    /// The selection status of the icon, which determines its visual state.
    @Binding var status: SelectionStatus
    
    /// The action to be performed when the icon is tapped.
    var action: () -> Void
    
    // Constants for layout
    private let imageSize: CGFloat = 200
    private let cornerRadius: CGFloat = 16
    private let checkmarkSize: CGFloat = 15
    private let checkmarkBackgroundSize: CGSize = CGSize(width: 40, height: 30)
    
    var body: some View {
        Button(action: action) {
            VStack {
                ZStack {
                    profileImage
                    statusOverlay
                }
                .frame(width: imageSize, height: imageSize)
                
                if status != .selected {
                    statusText
                }
            }
        }
        .accessibilityLabel(Text("Profile icon"))
        .accessibilityAddTraits(status == .selected ? .isSelected : .isButton)
    }
    
    /// The profile image view with a resizable image and shadow.
    private var profileImage: some View {
        Image(icon)
            .resizable()
            .frame(width: imageSize, height: imageSize)
            .cornerRadius(cornerRadius)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 4)
            .overlay(profileBorder)
    }
    
    /// The border around the profile image, which changes color based on the selection status.
    private var profileBorder: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .inset(by: 0.5)
            .stroke(borderColor, lineWidth: status == .selected ? 4 : 2)
    }
    
    /// The overlay view that contains the selection checkmark, displayed when the icon is selected.
    private var statusOverlay: some View {
        VStack {
            HStack {
                Spacer()
                if status == .selected {
                    checkmarkBackground
                }
            }
            Spacer()
        }
    }
    
    /// The background view for the checkmark, with an uneven rounded rectangle shape.
    private var checkmarkBackground: some View {
        ZStack {
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 14, bottomTrailing: 0, topTrailing: 15))
                .foregroundStyle(Color.tibbyBaseGreen)
                .frame(width: checkmarkBackgroundSize.width, height: checkmarkBackgroundSize.height)
            
            Image("TibbySymbolCheckmark")
                .resizable()
                .frame(width: checkmarkSize, height: checkmarkSize)
        }
    }
    
    /// The text displayed under the icon when it is not selected.
    private var statusText: some View {
        Text("Click to equip")
            .font(.typography(.label))
            .foregroundStyle(Color.tibbyBaseGrey)
            .padding()
    }
    
    /// The border color for the profile image, determined by the selection status.
    private var borderColor: Color {
        switch status {
        case .selected:
            return Color.tibbyBaseGreen
        case .locked, .unselected:
            return Color.tibbyBaseBlack
        }
    }
}

