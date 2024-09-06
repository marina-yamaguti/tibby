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
    var tibbyImage: Image
    var tibby: Tibby
    var wasAlreadyUnlocked: Bool
    
    @EnvironmentObject var constants: Constants
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var service: Service
    
    @State var circleHeight: CGFloat = 500
    @State var circleWidth: CGFloat = 200
    @State var changeScreen = false
    @State var currentIndex = 0
    @State var changeBackground = false
    @State var offset: CGFloat = 0
    @State private var timerSubscription: Cancellable? = nil
    @State var isBoucing = false
    @State var fadeText = false
    @State var firtTimeHere: Bool
    @State var goToHome = false
    
    
    var body: some View {
        if !changeScreen {
            ZStack {
                RoundedRectangle(cornerRadius: 200)
                    .frame(width:circleHeight, height: circleHeight)
                    .opacity(changeBackground ? 1 : 0)
                    .foregroundStyle(Color(red: 0.98, green: 0.98, blue: 0.98))
                VStack(spacing: 24) {
                    Spacer()
                    
                    Text(tibby.rarity)
                        .font(.typography(.display))
                        .bold()
                        .opacity(fadeText ? 0 : 1)
                    
                    
                    Text("rarity Tibby")
                        .font(.typography(.headline))
                        .opacity(fadeText ? 0 : 1)
                    
                    
                    
                    images[currentIndex]
                        .resizable()
                        .frame(width: 390, height: 390)
                        .offset(x: offset, y: offset)
                    
                    Spacer()
                }
            }.background(color)
                .onAppear {
                    self.toggleBouncing()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        withAnimation(.easeOut(duration: 0.5), {
                            fadeText = true
                        })
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.animate()
                        self.toggleBouncing()
                        HapticManager.instance.impact(style: .heavy)
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
            VStack(spacing: 24) {
                Spacer()
                Text(firtTimeHere ? "You Won your first Tibby:" : "You Won" )
                    .font(.typography(.title))
                
                Text(wasAlreadyUnlocked ? "\(self.convertCamelCaseToSpaces(tibby.species))" : "\(self.convertCamelCaseToSpaces(tibby.species))!")
                    .font(.typography(.headline))
                    .bold()
                    .lineSpacing(10)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                if wasAlreadyUnlocked {
                    
                    Text(tibby.isUnlocked ? "again...": "")
                        .font(.typography(.body))
                }
                
                tibbyImage
                    .resizable()
                    .frame(width: 390, height: 390)
                
                Button(action: {
                    if firtTimeHere {
                        UserDefaults.standard.setValue(false, forKey: "firstTimeHere")
                        if let user = service.getUser() {
                            user.currentTibbyID = tibby.id
                        }
                        
                        goToHome = true
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
                
                
                Spacer()
            }.background(color)
                .navigationDestination(isPresented: $goToHome, destination: { HomeView(tibby: tibby).navigationBarBackButtonHidden(true) })
        }
    }
    
    private func animate() {
        for index in 0..<self.images.count-1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.11, execute: {
                self.currentIndex += 1
            })
            self.currentIndex = 0
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


