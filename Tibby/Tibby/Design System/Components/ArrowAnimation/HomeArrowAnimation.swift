//
//  HomeArrowAnimation.swift
//  Tibby
//
//  Created by Sofia Sartori on 17/09/24.
//

import SwiftUI

struct HomeArrowAnimation: View {
    @State var startAnimation = true
    @State var timer = Timer.publish(every: 0.7, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack(spacing: 0) {
            Image(TibbySymbols.chevronLeftBlack.rawValue)
                .resizable()
                .foregroundColor(.black)
                .frame(width: 12, height: 20)
                .opacity(startAnimation ? 0.8 : 0.2)
                .rotationEffect(.degrees(90))
            Image(TibbySymbols.chevronLeftBlack.rawValue)
                .resizable()
                .foregroundColor(.black)
                .frame(width: 12, height: 20)
                .opacity(startAnimation ? 0.4 : 0.4)
                .rotationEffect(.degrees(90))
            Image(TibbySymbols.chevronLeftBlack.rawValue)
                .resizable()
                .foregroundColor(.black)
                .frame(width: 12, height: 20)
                .opacity(startAnimation ? 0.2 : 0.8)
                .rotationEffect(.degrees(90))
            

        }.onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 0.7)) {
                startAnimation.toggle()
            }
        }
    }
}

#Preview {
    HomeArrowAnimation()
}
