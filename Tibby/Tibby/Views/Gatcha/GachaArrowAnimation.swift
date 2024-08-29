//
//  GachaArrowAnimation.swift
//  Tibby
//
//  Created by Sofia Sartori on 29/08/24.
//

import SwiftUI
import Combine

struct GachaArrowAnimation: View {
    @State var startAnimation = true
    @State var timer = Timer.publish(every: 0.7, on: .main, in: .common).autoconnect()
    var body: some View {
        HStack {
            Image(TibbySymbols.chevronLeftBlack.rawValue)
                .resizable()
                .foregroundColor(.black)
                .frame(width: 12, height: 20)
                .opacity(startAnimation ? 1 : 0.2)
            Image(TibbySymbols.chevronLeftBlack.rawValue)
                .resizable()
                .foregroundColor(.black)
                .frame(width: 12, height: 20)
                .opacity(startAnimation ? 0.8 : 0.4)
            Image(TibbySymbols.chevronLeftBlack.rawValue)
                .resizable()
                .foregroundColor(.black)
                .frame(width: 12, height: 20)
                .opacity(startAnimation ? 0.6 : 0.6)
            Image(TibbySymbols.chevronLeftBlack.rawValue)
                .resizable()
                .foregroundColor(.black)
                .frame(width: 12, height: 20)
                .opacity(startAnimation ? 0.4 : 0.8)
            Image(TibbySymbols.chevronLeftBlack.rawValue)
                .resizable()
                .foregroundColor(.black)
                .frame(width: 12, height: 20)
                .opacity(startAnimation ? 0.2 : 1)

        }.onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 0.7)) {
                startAnimation.toggle()
            }
        }
    }
}

#Preview {
    GachaArrowAnimation()
}
