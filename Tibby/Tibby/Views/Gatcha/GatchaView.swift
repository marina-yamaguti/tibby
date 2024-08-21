//
//  GatchaView.swift
//  Tibby
//
//  Created by Sofia Sartori on 20/08/24.
//

import SwiftUI

struct GatchaView: View {
    @EnvironmentObject var service: Service
    @ObservedObject var vm = GatchaViewModel()
    @State var user: User? = nil
    @State var newTibby: Tibby? = nil
    @State var isAnimating = false
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State private var xOffset: CGFloat = 0
    @State private var isBaseOnFocus = true
    var body: some View {
        VStack {
            HStack {
                CustomBackButton()
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
                    Image(vm.gatchSeaSeriesAnimation[0])
                        .resizable()
                        .offset(x: isBaseOnFocus ? 470 : 0 + xOffset)
                        .scaleEffect(isBaseOnFocus ? 0.5 : 1)
                        .brightness(isBaseOnFocus ? -0.3 : 0)
                        .zIndex(isBaseOnFocus ? 0 : 1)
                    
                    Image(vm.gatchBaseAnimation[0])
                        .resizable()
                        .frame(width: 377, height: 420)
                        .offset(x: isBaseOnFocus ? 0 + xOffset : -470)
                        .scaleEffect(isBaseOnFocus ? 1 : 0.5)
                        .brightness(isBaseOnFocus ? 0 : -0.3)
                        .zIndex(isBaseOnFocus ? 1 : 0)
                    
                }.gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.width < 0 && isBaseOnFocus {
                                self.xOffset = value.translation.width
                                if xOffset <= -40 {
                                    withAnimation(.easeOut) {
                                        xOffset = 0
                                        isBaseOnFocus.toggle()
                                    }
                                }
                            }
                            
                            if value.translation.width > 0 && !isBaseOnFocus {
                                self.xOffset = value.translation.width
                                if xOffset >= 40 {
                                    withAnimation(.easeOut) {
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
            Button(action: {
                newTibby = vm.checkForRoll(service: service, isCoins: true, price: 100) {
                    isAnimating = true
                }
                isAnimating = true
                //print(newTibby?.name)
            }, label: {
                HStack {
                    Image(TibbySymbols.roll.rawValue)
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Roll")
                        .font(.typography(.title))
                        .foregroundStyle(.tibbyBaseBlack)
                        .padding(.horizontal)
                }
            }).buttonPrimary(bgColor: isBaseOnFocus ? .tibbyBaseYellow : vm.currentSeries.color).padding()
            
            HStack {
                Image(isBaseOnFocus ? "TibbyImageCoin" : "TibbyImageGem")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 8)
                Text(isBaseOnFocus ? "100" : "20")
                    .font(.typography(.title))
                    .foregroundStyle(.tibbyBaseWhite)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.black.opacity(0.5)))
        }.onAppear {
            if let user = service.getUser() {
                user.coins = 1000
                self.user = user
                
            }
            vm.updateCollectionBasedOnWeek()
        }.navigationBarBackButtonHidden(true)
            .background(isBaseOnFocus ? .tibbyBaseWhite : vm.currentSeries.color)
    }
}

