//
//  GatchaView.swift
//  Tibby
//
//  Created by Sofia Sartori on 20/08/24.
//

import SwiftUI

struct GatchaView: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @ObservedObject var vm = GatchaViewModel()
    @State var newTibby: Tibby? = nil
    @State var isAnimating = false
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State private var xOffset: CGFloat = 0
    @State private var isBaseOnFocus = true
    @State private var pressedButton = false
    @State private var backgroundcolor = Color.tibbyBaseWhite
    @State private var disableButton = false
    @State private var showCapsuleAnimation = false
    @State var wasAlreadyUnlocked = false
    
    var body: some View {
        if showCapsuleAnimation {
            if vm.newTibbyImage != nil  {
                CapsuleView(color: isBaseOnFocus ? .tibbyBaseWhite : vm.currentSeries.color, images: vm.getCapsuleAnimation(rarity: newTibby?.rarity), tibbyImage: vm.newTibbyImage!, tibby: newTibby!, wasAlreadyUnlocked: wasAlreadyUnlocked)
                    .navigationBarBackButtonHidden(true)
            }
        } else {
            VStack {
                HStack {
                    if !constants.firstTimeHere {
                        CustomBackButton()
                    }
                    Spacer()
                    MoneyView(viewModel: MoneyViewModel(moneyType: .gem, service: service)).padding(.horizontal)
                    MoneyView(viewModel: MoneyViewModel(moneyType: .coin, service: service))
                    
                }.padding()
                Text("Gacha")
                    .foregroundStyle(.tibbyBaseBlack)
                    .font(.typography(.body))
                Text( isBaseOnFocus ? "All Series" : vm.currentSeries.rawValue)
                    .foregroundStyle(.tibbyBaseBlack)
                    .font(.typography(.headline))
                    .bold()
                    .padding()
                Spacer()
                ZStack {
                    ZStack {
                        if vm.currentGatchaSecondaryImage != nil {
                            if !constants.firstTimeHere {
                                vm.currentGatchaSecondaryImage!
                                    .resizable()
                                    .offset(x: isBaseOnFocus ? UIScreen.main.bounds.width + UIScreen.main.bounds.width/5: 0 + xOffset)
                                    .scaleEffect(isBaseOnFocus ? 0.5 : 1)
                                    .brightness(isBaseOnFocus ? -0.3 : 0)
                                    .zIndex(isBaseOnFocus ? 0 : 1)
                                    .animation(.smooth, value: isBaseOnFocus)
                            }
                        }
                        
                        if vm.currentGatchaImage != nil {
                            vm.currentGatchaImage!
                                .resizable()
                                .frame(width: 377, height: 420)
                                .offset(x: isBaseOnFocus ? 0 + xOffset : -(UIScreen.main.bounds.width + UIScreen.main.bounds.width/5))
                                .scaleEffect(isBaseOnFocus ? 1 : 0.5)
                                .brightness(isBaseOnFocus ? 0 : -0.3)
                                .zIndex(isBaseOnFocus ? 1 : 0)
                                .animation(.smooth, value: isBaseOnFocus)
                        } else {
                            Rectangle()
                                .frame(width: 377, height: 420)
                                .hidden()
                        }
                        
                    }.gesture(
                        DragGesture()
                            .onChanged { value in
                                if !constants.firstTimeHere {
                                    if value.translation.width < 0 && isBaseOnFocus {
                                        self.xOffset = value.translation.width
                                        if xOffset <= -40 {
                                            xOffset = 0
                                            isBaseOnFocus.toggle()
                                            
                                            withAnimation(.smooth) {
                                                backgroundcolor =  vm.currentSeries.color
                                            }
                                        }
                                    }
                                    
                                    if value.translation.width > 0 && !isBaseOnFocus {
                                        self.xOffset = value.translation.width
                                        if xOffset >= 40 {
                                            withAnimation(.smooth) {
                                                backgroundcolor = .tibbyBaseWhite
                                            }
                                            xOffset = 0
                                            isBaseOnFocus.toggle()
                                        }
                                    }
                                }
                                
                            }
                            .onEnded { _ in
                                withAnimation(.easeOut) {
                                    xOffset = 0
                                }
                            }
                    )
                }
                if !constants.firstTimeHere {
                    HStack {
                        Spacer()
                        if isBaseOnFocus {
                            GachaArrowAnimation()
                        } else {
                            GachaArrowAnimation()
                                .rotationEffect(isBaseOnFocus ? .zero : .degrees(180))
                        }
                        Spacer()
                    }.padding(.bottom)
                }
                
                ButtonGacha(color: isBaseOnFocus ? .tibbyBaseYellow : vm.currentSeries.color, disableButton: $disableButton) {
                    if vm.checkForRoll(service: service, isCoins: isBaseOnFocus, price: isBaseOnFocus ? 100 : 20) {
                        self.disableButton = true
                        
                        vm.animateRoll(isBase: isBaseOnFocus)
                        newTibby = vm.getNewTibby(service: service, isCoins: isBaseOnFocus, price: isBaseOnFocus ? 100 : 20)
                        vm.getTibbyImage(species: newTibby?.species ?? "")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            showCapsuleAnimation = true
                        })
                        
                        self.wasAlreadyUnlocked = newTibby?.isUnlocked ?? false
                        newTibby?.isUnlocked = true
                    }
                }
                
                HStack {
                    Image(isBaseOnFocus ? "TibbyImageCoin" : "TibbyImageGem")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 8)
                    Text(isBaseOnFocus ? "100" : "20")
                        .font(.typography(.title))
                        .foregroundStyle(.black)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.tibbyBaseWhite.opacity(0.5)))
            }.onAppear {
                vm.updateCollectionBasedOnWeek()
                vm.loadCapsuleAnimation()
                vm.loadImages()
            }.navigationBarBackButtonHidden(true)
                .background(self.backgroundcolor)
                .onChange(of: self.pressedButton, {
                    
                })
        }
    }
}

