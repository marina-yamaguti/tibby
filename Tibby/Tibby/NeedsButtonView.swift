//
//  ButtonNavigation.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 17/07/24.
//

import SwiftUI

struct NeedsButton: View {
    var symbol: Symbols
    @State var pressed: Bool = false
    @ObservedObject var vm = NeedsButtonViewModel()
    @Binding var progress: Int
    
    var body: some View {
        ZStack {
            ZStack {
                ZStack {
                    Rectangle()
                        .frame(width: 85, height: 76)
                        .foregroundStyle(vm.getProgressColor(progress: progress))
                        .withBorderRadius(20)
                        .mask{
                            VStack {
                                if progress < 100 {
                                    Spacer()
                                }
                                Rectangle()
                                    .frame(height: vm.getProgressHeight(progress: progress))
                                    .withBorderRadius(20)
                                
                            }
                            .frame(height: 76)
                        }
                    
                    Rectangle()
                        .foregroundStyle(.tibbyBaseBlue)
                        .opacity(100)
                        .frame(width: 85, height: 76)
                        .opacity(0.2)
                        .withBorderRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.tibbyBaseBlack, lineWidth: 2)
                        )
                    HStack {
                        Image(symbol.rawValue)
                    }
                }
            }
        }
    }
}


//#Preview {
//    NeedsButton(symbol: .food, progress: 50)
//}
