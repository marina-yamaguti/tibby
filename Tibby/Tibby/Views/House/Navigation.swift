//
//  Navigation.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 15/07/24.
//

import SwiftUI
//MARK: Types of enviroments
enum Enviroment {
    case garden, kitchen, bedroom
    
    func getIconAsset() -> String {
        switch self {
        case .garden:
            return "tree.fill"
        case .kitchen:
            return "fork.knife"
        case .bedroom:
            return "bed.double.fill"
        }
    }
    
//    func getbackground() -> String {
//        switch self {
//        case .garden:
//            return ""
//        case .kitchen:
//            return ""
//        case .bedroom:
//            return ""
//        }
//    }
}

struct NavigationTabbarView: View {
    @EnvironmentObject var constants: Constants
    let tibby: Tibby
    let enviroments: [Enviroment] = [.kitchen, .bedroom, .garden]
    
    var body: some View {
        VStack {
            Spacer()
            //Decide the room depending on the button the user select
            switch constants.currentEnviroment {
            case .bedroom:
                BedroomView(tibby: tibby)
                    .brightness(constants.brightness)
            case .garden:
                GardenView(tibby: tibby)
                    .brightness(constants.brightness)
            case .kitchen:
                KitchenView(tibby: tibby)
                    .brightness(constants.brightness)
            }
            //Custom Tabbar
            HStack(spacing: 30){
                ForEach(0..<enviroments.count) { ind in
                    Button {
                        constants.currentEnviroment = enviroments[ind]
                    } label: {
                        //Image(systemName: enviroments[ind].getIconAsset())
                    }                    
                }
            }
        }
        .background(
            .tibbyBasePink
        )
    }

    
}
