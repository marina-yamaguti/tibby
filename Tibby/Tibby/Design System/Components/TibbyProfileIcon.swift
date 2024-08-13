//
//  TibbyProfileIcon.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

struct TibbyProfileIcon: View {
    @State var icon: Image
    
    var body: some View {
        ZStack {
            icon
                .resizable()
        }
        .frame(width: 200, height: 200)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(Color.tibbyBaseGreen, lineWidth: 2)
        )
    }
}

#Preview {
    TibbyProfileIcon(icon: Image("shark1Icon"))
}
