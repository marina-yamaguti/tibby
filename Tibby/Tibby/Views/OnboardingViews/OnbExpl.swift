//
//  OnbExpl.swift
//  Tibby
//
//  Created by Marina Yamaguti on 11/09/24.
//

import SwiftUI

struct OnbExpl: View {
    var body: some View {
        ZStack {
            Color.tibbyBaseBlack.opacity(0.5)
                .ignoresSafeArea()
            
            VStack() {
                Spacer()
                    
                VStack {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("Charlotte:")
                                .font(.typography(.body))
                                .padding(.bottom, 4)
                                .padding(.top, 8)
                            Text("Hey, welcome! Let's start your journey by getting your first Tibby! Click the big gold button to roll for a random Tibby.")
                                .font(.typography(.label))
                                .environment(\._lineHeightMultiple, 2)
                                .padding(.bottom, 8)
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.horizontal, 8)
                        .background(Color.tibbyBaseBlack.opacity(0.8))
                        .cornerRadius(20)
                        .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.tibbyBaseBlack, lineWidth: 2)
                        )
                        
                        HStack {
                            Spacer()
                            Text("Click anywhere to dismiss.")
                                .font(.typography(.label2))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
                   
                    HStack {
                        Image("onbExplanation")
                        Spacer()
                    }
                }                   
            }
        }
    }
}

#Preview {
    OnbExpl()
}
