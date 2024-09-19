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
                        .autocorrectionDisabled()
                        .padding()
                        .background(.tibbyBaseWhite)
                        .frame(width: 286, height: 36)
                        .cornerRadius(20)
                        .textInputAutocapitalization(.none)
                        .preferredColorScheme(.light)

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
                        viewModel.redeemCodeAction(service: service)
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.tibbyBasePearlBlue)
            }
        }
        .alert(isPresented: Binding<Bool>(
            get: {
                viewModel.showRedeemSuccess || viewModel.invalidAlert || viewModel.codeAlreadyRedeemedAlert
            },
            set: { _ in
                viewModel.showRedeemSuccess = false
                viewModel.invalidAlert = false
                viewModel.codeAlreadyRedeemedAlert = false
            })
        ) {
            if viewModel.showTestRedeem {
                return Alert(
                    title: Text("TEST CHEAT!"),
                    message: Text("Unlocking 1,000 coins."),
                    dismissButton: .default(Text("OK"))
                )
            } else if viewModel.codeAlreadyRedeemedAlert {
                return Alert(
                    title: Text("Code Already Redeemed"),
                    message: Text("You have already redeemed this code."),
                    dismissButton: .default(Text("OK"))
                )
            } else if viewModel.showRedeemSuccess {
                return Alert(
                    title: Text("Congratulations!"),
                    message: Text("You unlocked a new acessory, 20 gems and 100 coins!"),
                    dismissButton: .default(Text("OK"))
                )
            } else {
                return Alert(
                    title: Text("Invalid Code"),
                    message: Text("Oops! The code you entered is not valid. Please try again."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
