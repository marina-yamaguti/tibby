//
//  TibbyNameEdit.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

struct TibbyNameEdit: View {
    @Binding var tibby: Tibby
    @State private var isEditing: Bool = false
    @State private var textWidth: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Text(tibby.name)
                    .font(.typography(FontStyle.headline))
                    .background(GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                textWidth = geometry.size.width
                            }
                            .onChange(of: tibby.name) { _, _ in
                                textWidth = geometry.size.width
                            }
                    })
                    .hidden()
                
                if isEditing {
                    TextField(
                        "Given Name",
                        text: $tibby.name
                    )
                    .disableAutocorrection(true)
                    .font(.typography(FontStyle.headline))
                    .foregroundStyle(Color.tibbyBaseBlack)
                    .frame(width: textWidth)
                    .onChange(of: tibby.name) { _, newValue in
                        if newValue.count > 10 {
                            tibby.name = String(newValue.prefix(10))
                        }
                    }
                    .onSubmit {
                        isEditing = false
                    }
                } else {
                    Text(tibby.name)
                        .font(.typography(FontStyle.headline))
                        .foregroundStyle(Color.tibbyBaseBlack)
                        .frame(width: textWidth)
                        .onTapGesture {
                            isEditing = true
                        }
                }
            }
            
            //icon
            ZStack {
                Circle().foregroundStyle(isEditing ? Color.tibbyBaseGreen : .black.opacity(0.5))
                Image(systemName: isEditing ? "checkmark" : "pencil")
                    .resizable()
                    .frame(width: 7, height: 7)
                    .foregroundStyle(Color.tibbyBaseWhite)
            }
            .frame(width: 20, height: 20)
            .onTapGesture {
                if isEditing {
                    isEditing = false
                } else {
                    isEditing = true
                }
            }
        }.frame(height: 36)
    }
}

