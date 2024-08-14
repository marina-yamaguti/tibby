//
//  SwiftUIView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 19/07/24.
//

import SwiftUI

struct ConstantsColors {
static let TokensButtonPrimaryContainerBackgroundShadow: Color = Color(red: 0.3, green: 0.29, blue: 0)
static let TokensButtonPrimaryContainerStroke: Color = Color(red: 0.12, green: 0.11, blue: 0)
}

struct SwiftUIView: View {
    @State var alterState = false
    @State var tap = false
    @State var press = false

    var body: some View {
        ZStack {
            HStack(spacing: 30) {
                Image(TibbySymbols.play.rawValue)
                Text("Play")
                    .font(.typography(.title)).foregroundColor( alterState ? Color.tibbyBaseBlack : (tap ? Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)): Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))))
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
