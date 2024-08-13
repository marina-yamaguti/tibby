//
//  CustomBackButton.swift
//  Tibby
//
//  Created by Sofia Sartori on 09/08/24.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack {
                Circle().foregroundStyle(.black.opacity(0.5))
                Image(systemName: "chevron.left")
                    .foregroundStyle(.tibbyBaseWhite)
                    .font(.system(size: 14))
                    .bold()
                    .padding()
            }.frame(width: 30, height: 30)
        }
    }
}

#Preview {
    CustomBackButton()
}
