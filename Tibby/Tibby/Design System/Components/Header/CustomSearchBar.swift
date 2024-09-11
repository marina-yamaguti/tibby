//
//  CustomSearchBar.swift
//  Tibby
//
//  Created by Sofia Sartori on 04/09/24.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .font(Font.system(size: 21))
                .padding(8)
                .background(.white)
                .cornerRadius(50)
            ZStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.black.opacity(0.5))
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white)
                    .bold()
            }.padding(.leading, 16)
        }
        
        
    }
}


