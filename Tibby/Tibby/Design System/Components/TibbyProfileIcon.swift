//
//  TibbyProfileIcon.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

struct TibbyProfileIcon: View {
    @State var icon: String
    @Binding var status: SelectionStatus
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            VStack {
                ZStack {
                    Image(icon)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 4)
                        .overlay {
                            switch status {
                            case .selected:
                                RoundedRectangle(cornerRadius: 16)
                                    .inset(by: 0.5)
                                    .stroke(Color.tibbyBaseGreen, lineWidth: 2)
                            case .locked:
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.tibbyBaseBlack, lineWidth: 2)
                            case .unselected:
                                RoundedRectangle(cornerRadius: 16)
                                    .inset(by: 0.5)
                                    .stroke(Color.tibbyBaseBlack, lineWidth: 2)
                            }
                        }
                    
                    VStack {
                        HStack {
                            Spacer()
                            ZStack {
                                if status == .selected {
                                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 14, bottomTrailing: 0, topTrailing: 15))
                                        .foregroundStyle(Color.tibbyBaseGreen)
                                        .frame(width: 40, height: 30)
                                    
                                    Image("TibbySymbolCheckmark")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                }
                            }
                        }
                        Spacer()
                    }
                }.frame(width: 200, height: 200)
                if status != .selected {
                    Text("Click to equip")
                        .font(.typography(.label))
                        .foregroundStyle(Color.tibbyBaseGrey)
                        .padding()
                }
            }
        })
    }
}

//#Preview {
//    TibbyProfileIcon(icon: "shark1Icon", status: SelectionStatus.selected, action: { print("selected tibby")})
//}
