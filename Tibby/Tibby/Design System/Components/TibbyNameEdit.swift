//
//  TibbyNameEdit.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

struct TibbyNameEdit: View {
    @State var name: String
    @State private var isEditing: Bool = false
    @State private var textWidth: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Text(name)
                    .font(.typography(FontStyle.headline))
                    .background(GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                textWidth = geometry.size.width
                            }
                            .onChange(of: name) { oldValue, newValue in
                                textWidth = geometry.size.width
                            }
                    })
                    .hidden()
                
                TextField(
                    "Given Name",
                    text: $name
                )
                .disableAutocorrection(true)
                .font(.typography(FontStyle.headline))
                .foregroundStyle(Color.tibbyBaseBlack)
                .frame(width: textWidth)
            }
            
            ZStack {
                Circle().foregroundStyle(.black.opacity(0.5))
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 7, height: 7)
                    .foregroundStyle(Color.tibbyBaseWhite)
            }
            .frame(width: 20, height: 20)
        }.frame(height: 36)
    }
}

#Preview {
    TibbyNameEdit(name: "Shark")
}
