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
            return TibbySymbols.dumbbellBlack
        case .kitchen:
            return TibbySymbols.kitchenBlack
        case .bedroom:
            return TibbySymbols.sleepBlack
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
    @State var offset = UIScreen.main.bounds.height
    let enviroments: [Enviroment] = [.kitchen, .bedroom, .garden]
    @State var timeGoal: Int = UserDefaults.standard.value(forKey: "workout") as? Int ?? 30
    @State var stepsGoal: Int = UserDefaults.standard.value(forKey: "steps") as? Int ?? 500
    
    var body: some View {
        
        ZStack {
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
                HStack(spacing: 30) {
                    ForEach(0..<enviroments.count) { ind in
                        Button(action: {constants.currentEnviroment = enviroments[ind]},
                               label: {
                            ButtonLabel(type: .tabBar, image: enviroments[ind].getIconAsset().rawValue, text: "")
                        })
                        .buttonTabBar()
                    }
                }
                .frame(height: 80)
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(edges: [.top])
            .background(
                .tibbyBaseWhite
            )
            if constants.showWorkoutSession, constants.workout != nil {
                VStack {
                    WorkoutSessionView(image: "\(vm.tibby.species)1", workout: constants.workout!, offset: $offset, stepsGoal: stepsGoal, timeGoal: timeGoal)
                        .offset(y: offset)
                        .onAppear {
                            withAnimation(.easeIn(duration: 0.2), {
                                self.offset = 0
                            })
                        }
                    //                        .onDisappear {
                    //                            withAnimation(.easeIn(duration: 0.1), {
                    //                                self.offset = UIScreen.main.bounds.height
                    //                            })
                    //
                    //                        }
                    
                }.padding(.top, 38)
                    .navigationBarBackButtonHidden(true)
                    .ignoresSafeArea(edges: [.bottom])
                    .background(
                        .tibbyBaseWhite
                    )
                
            }
            if constants.showSleepSession {
                VStack {
                    SleepView(offset: $offset, tibby: vm.tibby)
                        .offset(y: offset)
                        .onAppear {
                            withAnimation(.easeIn(duration: 0.2), {
                                self.offset = 0
                            })
                        }
                    //                        .onDisappear {
                    //                            withAnimation(.easeIn(duration: 0.1), {
                    //                                self.offset = UIScreen.main.bounds.height
                    //                            })
                    //
                    //                        }
                    
                }
                .padding(.top, 38)
                .navigationBarBackButtonHidden(true)
                .ignoresSafeArea(edges: [.bottom])
                .background(
                    .tibbyBaseWhite
                )
                
            }
        }
    }
}

