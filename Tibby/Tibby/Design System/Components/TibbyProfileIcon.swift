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
        VStack {
            ZStack {
                profileImage
            }
            .frame(width: imageSize, height: imageSize)
        }
        .overlay{
            profileBorder
        }
        .accessibilityLabel(Text("Profile icon"))
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
            .stroke(.tibbyBaseBlack, lineWidth: status == .selected ? 1 : 0)
    }
}

