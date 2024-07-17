//
//  KitchenView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 15/07/24.
//

import SwiftUI
import SpriteKit

struct KitchenView: View {
    
    @EnvironmentObject var service: Service
    var tibby: Tibby
    @State var isEating = false
    @State var tibbyView: TibbyProtocol = TibbyView()
    @State var selectedFood: Food?
    
    @State var mouth = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/1.5)
    @GestureState var plate = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/3)
    @State var foodLocation = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/3)
    @State var toEat = true
    var platePos = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/3)
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                    ZStack {
                        SpriteView(scene: tibbyView as! SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                            .position(mouth)
//                        Rectangle()
//                            .foregroundStyle(.red)
//                            .frame(width: 50, height: 50)
//                            .position(mouth)
                    }
                    if selectedFood != nil {
                        HStack {
                            if toEat {
                                Image(selectedFood!.image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .position(foodLocation)
                                    .gesture(
                                        DragGesture()
                                            .onChanged({ state in
                                                self.isEating = true
                                                foodLocation = state.location
                                                if (foodLocation.x >= mouth.x - 20 && foodLocation.x <= mouth.x + 20 && foodLocation.y >= mouth.y - 50 && foodLocation.y <= mouth.y + 50) {
                                                    toEat = false
                                                    isEating = false
                                                    selectedFood = nil
                                                    foodLocation = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height/3)
                                                    
                                                    //delete food from inventory
                                                    
                                                    //update tibby hunger atribute
                                                }
                                                
                                            })
                                            .onEnded({ state in
                                                self.isEating = false
                                                withAnimation {
                                                    foodLocation = platePos
                                                }
                                            })
//                                            .updating($plate, body: { currentState, pastLocation, transaction in
//                                                pastLocation = currentState.location
//                                            })
                                    )
                            }
                            //Spacer()
                        }
                    }
                    else {
                        VStack {
                            Spacer()
                            ScrollView(.horizontal) {
                                ForEach(service.getFoodsFromUser().sorted(by: {$0.key.name < $1.key.name}), id: \.key) { key, value in
                                    ZStack {
                                        VStack {
                                            Image(key.image)
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                                .padding()
                                                .onTapGesture {
                                                    self.toEat = true
                                                    self.selectedFood = key
                                                }
                                        }
                                    }.padding()
                                }
                            }.background(Rectangle().stroke(lineWidth: 1.0))
                                .padding()
                        }
                    }
                
            }
        }.onAppear {
            tibbyView.animateTibby(["shark1", "shark2"], nodeID: .tibby, timeFrame: 0.5)
            if service.getFoodsFromUser().isEmpty {
                service.addFoodToUser(food: service.getAllFoods().first!)
            }
        }
    }
}
