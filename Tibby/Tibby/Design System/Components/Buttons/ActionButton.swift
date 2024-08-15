//
//  ActionButton.swift
//  Tibby
//
//  Created by Sofia Sartori on 13/08/24.
//

import SwiftUI

struct ActionButton: View {
    var image: String
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }, label: {
            ZStack {
                Circle()
                    .foregroundStyle(.black.opacity(0.5))
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .padding(12)
            }.frame(width: 40, height: 40)
        })
    }
}

