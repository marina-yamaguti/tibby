//
//  UserProfileComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/09/24.
//

import SwiftUI

struct UserProfileComponent: View {
    @Binding var currentTibby: Tibby
    @State var isEditing: Bool = false
    @State var user: User
    @FocusState private var isFocused: Bool
    @State private var stateColor: Color = .tibbyBaseGrey
    var currentXp: Int = 30
    var xpToEvolve: Int = 100
    let characterLimit: Int = 10

    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image("\(currentTibby.species)Icon")
                    .resizable()
                    .frame(width: 110, height: 110)
                    .cornerRadius(20)
                
                VStack(alignment: .leading) {
                    HStack {
                        if isEditing {
                            TextField("Name", text: $user.username)
                                .disableAutocorrection(true)
                                .font(.typography(.title))
                                .foregroundStyle(Color.tibbyBaseBlack)
                                .onChange(of: user.username) {oldValue, newValue in
                                    if newValue.count > characterLimit {
                                        user.username = String(newValue.prefix(characterLimit))
                                        HapticManager.instance.impact(style: .heavy)
                                    } else if  newValue.count == characterLimit {
                                        stateColor = .red
                                    } else {
                                        stateColor = .tibbyBaseGrey
                                    }
                                }
                                .onSubmit {
                                    isEditing = false
                                }
                                .focused($isFocused)
                            
                            Text("\(user.username.count)/\(characterLimit)")
                                .font(.caption)
                                .foregroundColor(stateColor)
                            
                        } else {
                            Text(user.username)
                                .font(.typography(.title))
                                .foregroundStyle(.tibbyBaseBlack)
                        }
                        Spacer()
                        Button(action: {
                            isEditing.toggle()
                            isFocused.toggle()}
                        ) {
                            ButtonLabel(type: .secondary, image: isEditing ? TibbySymbols.checkmarkWhite.rawValue: TibbySymbols.penWhite.rawValue, text: "")
                        }
                        .buttonSmallRounded(bgColor: isEditing ? .tibbyBaseSaturatedGreen : .black.opacity(0.5))
                    }
                    Spacer()
                    HStack {
                        Text("Tibby:")
                            .font(.typography(.label2))
                            .foregroundStyle(.tibbyBaseGrey)
                        
                        Text(currentTibby.name)
                            .font(.typography(.label))
                            .foregroundStyle(.tibbyBaseBlack)
                    }
                    Spacer()

                    HStack(alignment: .center) {
                        Text("Lv. \(user.level)")
                            .font(.typography(.body))
                            .foregroundStyle(.tibbyBaseBlack)
                        Spacer()
                        Text("\(user.xp)/\(xpToEvolve) xp")
                            .font(.typography(.label2))
                            .foregroundStyle(.tibbyBaseGrey)
                    }
                    ProgressView(value: Double(user.xp), total: Double(xpToEvolve))
                        .progressViewStyle(CustomProgressBar(barType: .xp))
                }
            }

            CustomDivider()
        }
    }
}
