//
//  SwiftUIView.swift
//  Tibby
//
//  Created by Sofia Sartori on 09/08/24.
//

import SwiftUI

struct RetroNavigationBar: View {
    @Environment(\.presentationMode) var presentationMode
    @State var goToSettings: Bool = false
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .aspectRatio(4, contentMode: .fit)
                            .foregroundStyle(.tibbyBaseBlack)
                            .offset(y: 3)
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundStyle(.tibbyBaseBlack)
                            .aspectRatio(4, contentMode: .fit)
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [.white.opacity(0), .white]),
                                    startPoint: .topTrailing,
                                    endPoint: .bottomLeading
                                ),
                                lineWidth: 2
                            ).opacity(0.25)
                            .foregroundStyle(.linearGradient(colors: [.tibbyBaseBlack.opacity(0.45), .tibbyBaseBlack], startPoint: .leading, endPoint: .trailing))
                        
                            .aspectRatio(4, contentMode: .fit)
                        
                    }
                    .frame(maxWidth: 65)
                })
                
                Text("home")
                    .foregroundStyle(.tibbyBaseBlack)
                    .font(.typography(.label))
                    .padding(.top, 4)
                
            }.padding(.leading)
            Spacer()
            VStack {
                VStack {
                    HStack {
                        ForEach(0..<10, id: \.self) { _ in
                            Circle()
                                .fill(.tibbyBaseGrey)
                                .frame(width: 5, height: 5)
                        }
                    }
                    HStack {
                        ForEach(0..<8, id: \.self) { _ in
                            Circle()
                                .fill(.tibbyBaseGrey)
                                .frame(width: 5, height: 5)
                        }
                    }
                }
                Text("tibby")
                    .foregroundStyle(.tibbyBaseBlack)
                    .font(.typography(.headline))
                    .lineLimit(1)
                    .layoutPriority(1)
                    .padding(.vertical)
            }
            Spacer()
//            Button(action: {goToSettings = true}, label: {ButtonLabel(type: .tertiary, image: "", text: "")})
//                .buttonTertiary()
            VStack(alignment: .trailing) {
                NavigationLink(destination: SettingsView(), label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .aspectRatio(4, contentMode: .fit)
                            .foregroundStyle(.tibbyBaseBlack)
                            .offset(y: 3)
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundStyle(.tibbyBaseBlack)
                            .aspectRatio(4, contentMode: .fit)
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [.white.opacity(0), .white]),
                                    startPoint: .topTrailing,
                                    endPoint: .bottomLeading
                                ),
                                lineWidth: 2
                            ).opacity(0.25)
                            .foregroundStyle(.linearGradient(colors: [.tibbyBaseBlack.opacity(0.45), .tibbyBaseBlack], startPoint: .leading, endPoint: .trailing))
                        
                            .aspectRatio(4, contentMode: .fit)
                        
                    }
                    .frame(maxWidth: 65)
                })
                Text("settings")
                    .foregroundStyle(.tibbyBaseBlack)
                    .font(.typography(.label))
                    .padding(.top, 4)
                
            }
            .padding(.trailing)
        }
    }
}

#Preview {
    RetroNavigationBar()
}
