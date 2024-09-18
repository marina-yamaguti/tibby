//
//  CodeRedeemView.swift
//  Tibby
//
//  Created by Madu Maciel on 17/09/24.
//

import SwiftUI

import SwiftUI

struct CodeRedeemView: View {
    @StateObject var viewModel: SettingsViewModel
    @EnvironmentObject var service: Service

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .fill(Color.tibbyBaseYellow)
                    .frame(width: 20, height: 20)
                Text("Redeem Code")
                    .font(.typography(.label))
                    .foregroundStyle(Color.tibbyBaseBlack)
            }
            .padding(.vertical, 8)
            
            VStack {
                HStack {
                    TextField("Enter Code", text: $viewModel.redeemCode)
                        .padding()
                        .background(.tibbyBaseWhite)
                        .frame(width: 286, height: 36)
                        .cornerRadius(20)
                        .textInputAutocapitalization(.none)
                    
                    ZStack {
                        Circle()
                            .foregroundStyle(.tibbyBackgroundShadowBlack.opacity(0.5))
                            .frame(width: 40, height: 40)
                        Image(TibbySymbols.checkmarkWhite.rawValue)
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(Color.tibbyBaseWhite)
                    }
                    .onTapGesture {
                        if viewModel.isValidCode() {
                            viewModel.redeemCodeAction(service: service)
                        }
                    }
                    .disabled(!viewModel.isValidCode())
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.tibbyBasePearlBlue)
            }
        }
        .alert(isPresented: $viewModel.showRedeemSuccess) {
            Alert(title: Text("Congratulations!"),
                  message: Text("You unlocked 1,000 coins."),
                  dismissButton: .default(Text("OK")))
        }
    }
}
