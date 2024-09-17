//
//  CapsuleView.swift
//  Tibby
//
//  Created by Sofia Sartori on 21/08/24.
//

import SwiftUI
import Combine

struct CapsuleView: View {
    
    var color: Color
    var images: [Image]
    var sparkImages: [Image]
    var tibbyImage: Image
    var tibby: Tibby
    var wasAlreadyUnlocked: Bool
    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    @EnvironmentObject var constants: Constants
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var service: Service
    
    @State var circleHeight: CGFloat = 500
    @State var circleWidth: CGFloat = 200
    @State var changeScreen = false
    @State var currentIndex = 0
    @State var currentIndexSparks = 0
    @State var changeBackground = false
    @State var offset: CGFloat = 0
    @State private var timerSubscription: Cancellable? = nil
    @State var isBoucing = false
    @State var fadeText = false
    @Binding var firstTimeHere: Bool
//    @State var goToHome = false
    
    
    
    
    var body: some View {
        if !changeScreen {
            ZStack {
                RoundedRectangle(cornerRadius: 200)
                    .frame(width:circleHeight, height: circleHeight)
                    .opacity(changeBackground ? 1 : 0)
                    .foregroundStyle(Color(red: 0.98, green: 0.98, blue: 0.98))
                VStack() {
                    Spacer()
                    //capsule
                    images[currentIndex]
                        .resizable()
                        .frame(width: 390, height: 390)
                        .offset(x: offset, y: offset)
                    Spacer()
                }
            }.background(color)
                .onAppear {
                    self.toggleBouncing()
                    AudioManager.instance.playMusic(audio: .suspenseGachaPull)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        withAnimation(.easeOut(duration: 0.5), {
                            fadeText = true
                        })
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.animate(images: images, currentIndex: $currentIndex, duration: 0.11)
                        self.toggleBouncing()
                        HapticManager.instance.impact(style: .heavy)
                        AudioManager.instance.playSFX(audio: .capsuleOpen)
                    })
                    
                    
                }
                .onChange(of: currentIndex, {
                    if currentIndex == images.count - 1 {
                        changeBackground = true
                        withAnimation(.snappy(duration: 0.2)) {
                            circleHeight = 1000
                        }
                    }
                })
                .onChange(of: circleHeight, {
                    if circleHeight == 1000 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                            withAnimation(.interactiveSpring(duration: 1)) {
                                changeScreen = true
                            }
                        })
                        
                    }
                })
        } else {
            VStack(alignment: .center, spacing: 24) {
                Spacer()
                Text(firstTimeHere ? "You Won your first Tibby:" : "You Won" )
                    .font(.typography(.title))
                    .padding(.top, 32)
                    .padding(.horizontal, 8)
                    
                
                Text("\(self.convertCamelCaseToSpaces(tibby.species))!")
                    .font(.typography(.headline))
                    .bold()
                    .lineSpacing(10)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Spacer()
                    RarityLabel(capsule: images[0], rarity: tibby.rarity)
                    
                    if wasAlreadyUnlocked {
                        RarityLabel(capsule: Image(TibbySymbols.duplicate.rawValue), rarity: "duplicate")
                    }
                    Spacer()
                }
                
                ZStack {
                    tibbyImage
                        .resizable()
                        .scaledToFit()
                        .onAppear {
                            AudioManager.instance.playSFX(audio: tibby.rarity == "Common" ? .commonPull : (tibby.rarity == "Rare" ? .rarePull : .epicPull))
                        }
                    sparkImages[currentIndexSparks]
                        .resizable()
                        .scaledToFit()
                        .onReceive(timer, perform: { _ in
                            if currentIndexSparks == sparkImages.count - 1 {
                                currentIndexSparks = 0
                            } else {
                                currentIndexSparks += 1
                            }
                        })
                }
                
                Button(action: {
                    if firstTimeHere {
                        if let user = service.getUser() {
                            user.currentTibbyID = tibby.id
                        }
                        
                        UserDefaults.standard.setValue(false, forKey: "firstTimeHere")
                        firstTimeHere = false
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    HStack {
                        Image(TibbySymbols.checkMark.rawValue)
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text("Okay")
                            .font(.typography(.title))
                            .foregroundStyle(.tibbyBaseBlack)
                            .padding(.horizontal)
                    }
                }).buttonPrimary(bgColor: color == .tibbyBaseWhite ? .tibbyBaseYellow : color)
                    .padding(.bottom)
                
            }.background(color)
                .foregroundStyle(.tibbyBaseBlack)
        }
    }
    
    func animate(images: [Image], currentIndex: Binding<Int>, duration: Double) {

            for index in 0..<images.count-1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * duration, execute: {
                    currentIndex.wrappedValue += 1
                })
                currentIndex.wrappedValue = 0
            }
        
    }
    
    private func convertCamelCaseToSpaces(_ input: String) -> String {
        // Transforma o primeiro caractere em minúscula
        let lowercaseInput = input.prefix(1).uppercased() + input.dropFirst()
        
        // Substitui as letras maiúsculas por um espaço seguido da letra minúscula correspondente
        let spacedString = lowercaseInput.reduce("") { result, character in
            if character.isUppercase {
                return result + " " + character.uppercased()
            } else {
                return result + String(character)
            }
        }
        
        return spacedString
    }
    
    private func toggleBouncing() {
        isBoucing.toggle()
        if isBoucing {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    private func startTimer() {
        var bounceTogle = false
        timerSubscription = Timer.publish(every: 0.1, on: .main, in: .default)
            .autoconnect()
            .sink { _ in
                if bounceTogle {
                    HapticManager.instance.impact(style: .rigid)
                    offset += 3
                } else {
                    offset -= 3
                }
                bounceTogle.toggle()
            }
    }
    
    private func stopTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
}


