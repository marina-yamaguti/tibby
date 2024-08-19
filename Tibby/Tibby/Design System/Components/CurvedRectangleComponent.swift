//
//  CurvedRectangleComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 18/07/24.
//

import SwiftUI

/// A view that displays a rectangle with unevenly rounded corners.
///
/// `CurvedRectangleComponent` creates a rectangle with custom rounded corners, providing a distinctive visual style.
/// The corners are rounded more on the bottom sides and left sharp on the top sides.
struct CurvedRectangleComponent: View {
    var body: some View {
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 45, bottomTrailing: 45, topTrailing: 0))
                .foregroundStyle(Color.tibbyBaseBlue)
    }
}
