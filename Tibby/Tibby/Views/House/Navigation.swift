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
    
    func getIconAsset() -> Symbols {
        switch self {
        case .garden:
            return Symbols.ball
        case .kitchen:
            return Symbols.food
        case .bedroom:
            return Symbols.sleepy
        }
    }
    
    func getTibbyProperties(tibby: Tibby) -> Binding<Int> {
        switch self {
        case .garden:
                return Binding<Int>(
                    get: { tibby.happiness },
                    set: { tibby.happiness = $0 }
                )
            case .kitchen:
                return Binding<Int>(
                    get: { tibby.hunger },
                    set: { tibby.hunger = $0 }
                )
            case .bedroom:
                return Binding<Int>(
                    get: { tibby.sleep },
                    set: { tibby.sleep = $0 }
                )
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
    @EnvironmentObject var service: Service
    @ObservedObject var vm: NavigationViewModel
    let enviroments: [Enviroment] = [.kitchen, .bedroom, .garden]
    
    var body: some View {
        VStack {
            Spacer()
            //Decide the room depending on the button the user select
            switch constants.currentEnviroment {
            case .bedroom:
                BedroomView(tibby: vm.tibby)
                    .brightness(constants.brightness)
            case .garden:
                GardenView(tibby: vm.tibby)
                    .brightness(constants.brightness)
            case .kitchen:
                KitchenView(tibby: vm.tibby, selectedFood: service.getFoodsFromUser().keys.first)
                    .brightness(constants.brightness)
            }
            //Custom Tabbar
            HStack(spacing: 30){
                ForEach(0..<enviroments.count) { ind in
                    NeedsButton(symbol: enviroments[ind].getIconAsset(), progress: enviroments[ind].getTibbyProperties(tibby: vm.tibby))
                        .onTapGesture {
                            constants.currentEnviroment = enviroments[ind]
                        }
                }
            }
        }
        .background(
            .tibbyBaseWhite
        )
    }
}
