//
//  CustomPopUpView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 22/09/24.
//

import SwiftUI

struct CustomPopUpView: View {
    @Binding var isPresented: Bool
    var title: String
    var description: String
    var actionType: PopUpActionType
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Text
            Text(title)
                .font(.typography(.body))
                .foregroundColor(.tibbyBaseBlack)
                .padding(.top, 10)
            
            // Main Message Text
            Text(description)
                .font(.typography(.label2))
                .multilineTextAlignment(.center)
                .foregroundColor(.tibbyBaseBlack)
                .frame(minHeight: 64)
                .padding(16)
            
            Divider()
            
            // Buttons
            HStack {
                Spacer()
                if actionType == .settings {
                    // Cancel Button
                    createButton(image: TibbySymbols.xmarkWhite.rawValue, text: "Cancel", backgroundColor: .tibbyBaseGrey) {
                        isPresented = false
                    }
                    
                    Spacer()
                    Divider()
                        .frame(height: 56)

                    Spacer()
                }
     
                // Action Button
                createButton(image: actionType.symbol, text: actionType.description, backgroundColor: .tibbyBaseSaturatedGreen) {
                    if actionType == .settings {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                        isPresented = false

                    } else {
                        isPresented = false
                    }
                }
                .padding(actionType == .ok ? 8 : 0)
                
                Spacer()
            }
        }
        .frame(width: 300, height: 180)
        .background(.tibbyBaseWhite.opacity(0.9))
        .cornerRadius(25)
        .shadow(radius: 10)
    }
    
    // Reusable button creation function
    private func createButton(image: String, text: String, backgroundColor: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(alignment: .center) {
                Image(image)
                    .resizable()
                    .padding(4)
                    .background {
                        Circle()
                            .fill(backgroundColor)
                    }
                    .frame(width: 20, height: 20)
                
                Text(text)
                    .font(.typography(.body2))
                    .foregroundColor(text == "Cancel" ? .tibbyBaseGrey : .tibbyBaseBlack)
            }
        }
    }
}

enum PopUpActionType {
    case ok
    case settings
    
    var description: String {
        switch self {
        case .ok: return "Ok"
        case .settings: return "Settings"
        }
    }
    
    var symbol: String {
        switch self {
        case .ok: return TibbySymbols.checkmarkWhite.rawValue
        case .settings: return TibbySymbols.gearWhite.rawValue
        }
    }
}


