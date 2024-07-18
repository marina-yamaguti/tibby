//
//  TibbyPicker.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 17/07/24.
//

import SwiftUI

struct TibbyPicker: View {
    @State var tibbyName: String = ""
    @State var status: SelectionStatus
    var image: String
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack {
                    if status == .locked {
                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 14, bottomTrailing: 0, topTrailing: 20))
                            .foregroundStyle(Color.tibbyBaseGrey)
                            .frame(width: 40, height: 30)
                        Image("TibbySymbolLock")
                            .resizable()
                            .frame(width: 15, height: 15)
                    } else if status == .selected {
                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 14, bottomTrailing: 0, topTrailing: 20))
                            .foregroundStyle(Color.tibbyBaseGreen)
                            .frame(width: 40, height: 30)
                                Image("TibbySymbolCheckmark")
                            .resizable()
                            .frame(width: 15, height: 15)
                    } else {
                        
                    }
                }
            }
            Image(image)
                .resizable()
                .scaledToFit()
            TibbyNameComponent(name: tibbyName)
            .padding()
        }
        .overlay {
            if status == .unselected {
                
            } else if status == .selected {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.tibbyBaseGreen, lineWidth: 5)
            }
            else {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.tibbyBaseGrey, lineWidth: 5)
            }
        }
        .padding(40)
    }
}

#Preview {
    TibbyPicker(tibbyName: "Tibby Name", status: .selected, image: "shark1")
}
