//
//  TibbyPicker.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 17/07/24.
//

import SwiftUI

struct ItemCard: View {
    @Binding var name: String
    @State var status: SelectionStatus
    var color: Color
    var image: String
    
    var body: some View {
        ZStack {
            Color.tibbyBaseWhite
                .cornerRadius(15)
                .overlay {
                    switch status {
                    case .unselected:
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.tibbyBaseBlack, lineWidth: 1)
                    case .selected:
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.tibbyBaseGreen, lineWidth: 1)
                    case .locked:
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.tibbyBaseGrey, lineWidth: 1)
                    }
                }
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .brightness(status == .locked ? -1 : 0)
                        .padding(.bottom, 30)
                        .padding(.top, 8)
                }
            }
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    ZStack {
                        if status == .locked {
                            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 14, bottomTrailing: 0, topTrailing: 15))
                                .foregroundStyle(Color.tibbyBaseGrey)
                                .frame(width: 40, height: 30)
                            Image("TibbySymbolLock")
                                .resizable()
                                .frame(width: 15, height: 15)
                        } else if status == .selected {
                            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 14, bottomTrailing: 0, topTrailing: 15))
                                .foregroundStyle(Color.tibbyBaseGreen)
                                .frame(width: 40, height: 30)
                                    Image("TibbySymbolCheckmark")
                                .resizable()
                                .frame(width: 15, height: 15)
                        } else {
                            
                        }
                    }
                }
                Spacer()
                HStack {
                    Text(status == .locked ? "???" : name)
                        .font(.typography(.label2))
                        .padding(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                        .foregroundColor(Color.tibbyBaseBlack)
                       
                }
                .background(color)
                .cornerRadius(20)
                .padding(.bottom)
                .padding(.horizontal)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

