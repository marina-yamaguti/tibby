//
//  ConnectionView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 20/09/24.
//

import SwiftUI

import SwiftUI

struct ConnectionView: View {
    var retryAction: () -> Void  // Retry action passed from the parent view

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.tibbyBaseBlack.ignoresSafeArea()

                Image("LightbulbImage")
                    .position(
                        x: geometry.size.width - geometry.safeAreaInsets.trailing - 100,
                        y: geometry.safeAreaInsets.bottom
                    )

                VStack(spacing: 16) {
                    Text("Hey!")
                        .font(.typography(.display))
                        .foregroundStyle(.tibbyBaseSaturatedRed)
                        .padding(.top, 100)

                    Text("Who turned the lights out?")
                        .font(.typography(.title))
                        .foregroundStyle(.tibbyBaseWhite)
                        .kerning(0.15)
                        .multilineTextAlignment(.center)

                    Image("shark1")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 150)

                    Text("Make sure you are connected to the internet to be able to interact with your Tibbies again.")
                        .font(.typography(.body2))
                        .foregroundStyle(.tibbyBaseWhite)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Button(action: retryAction) {  // Retry Action
                        HStack {
                            Image(TibbySymbols.rollBlack.rawValue)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                            Text("Try Again")
                                .font(.typography(.title))
                                .padding(.horizontal)
                        }
                    }
                    .buttonPrimary(bgColor: .tibbyBaseBlue)
                    .frame(maxHeight: 80)
                    .padding(.bottom, 48)
                }
                .padding(16)
            }
        }
    }
}
