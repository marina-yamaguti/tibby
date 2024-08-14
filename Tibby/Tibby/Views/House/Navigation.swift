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
    
    func getIconAsset() -> TibbySymbols {
        switch self {
        case .garden:
            return TibbySymbols.ball
        case .kitchen:
            return TibbySymbols.food
        case .bedroom:
            return TibbySymbols.sleepy
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
}

struct NavigationTabbarView: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @ObservedObject var vm: NavigationViewModel
    let enviroments: [Enviroment] = [.kitchen, .bedroom, .garden]
    
    var body: some View {
        VStack {
            RetroNavigationBar()
                .padding(.top, 60)
                //Decide the room depending on the button the user select
                switch constants.currentEnviroment {
                case .bedroom:
                    BedroomView(tibby: vm.tibby, vm: BedroomViewModel(constants: constants, service: service))
                case .garden:
                    GardenView(tibby: vm.tibby)
                case .kitchen:
                    KitchenView(tibby: vm.tibby, selectedFood: service.getFoodsFromUser().keys.first)
                }
                //Custom Tabbar
                HStack(spacing: 30){
                    ForEach(0..<enviroments.count) { ind in
                        Button(action: {constants.currentEnviroment = enviroments[ind]},
                               label: {ButtonLabel(type: .tabBar, image: enviroments[ind].getIconAsset().rawValue, text: "")}
                        )
                        .buttonTabBar()
                    }
                }
            }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: [.top])
        .background(
            .tibbyBaseWhite
        )
    }
}
