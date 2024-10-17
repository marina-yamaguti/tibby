//
//  OnboardingTab.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//
import SwiftUI

struct OnboardingTab: View {
//    @ObservedObject var vm = OnboardingTabViewModel()
    @Binding var firstTime: Bool
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @EnvironmentObject var healthManager: HealthManager
    @State var name: String =  ""
    @State private var showingPopUp = false
    @State private var openHealth = false
    @Binding var currentTibby: Tibby?
    
    @State var onboardingViews: [OnboardingViews] = [.onboarding1, .onboarding2, .onboarding3, .onboarding4, .gacha]
    @State var currentIndex: Int = 0
    var currentOnboarding: OnboardingViews {
        return onboardingViews[currentIndex]
    }
    
    func nextPage() {
        if currentIndex <= 4 {
            currentIndex += 1
        }
    }
    
    func previousPage() {
            currentIndex -= 1
    }
    
    var body: some View {
        ZStack {
            if self.currentOnboarding != .gacha {
                VStack(alignment: .leading) {
                    HStack {
                        if self.currentIndex == 0 {
                            Button(action: {self.previousPage()}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.chevronLeftWhite.rawValue, text: "")})
                                .buttonSecondary(bgColor: .black.opacity(0.5))
                                .hidden()
                        } else {
                            Button(action: {self.previousPage()}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.chevronLeftWhite.rawValue, text: "")})
                                .buttonSecondary(bgColor: .black.opacity(0.5))
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 24))
            }
            VStack {
                if self.currentOnboarding != .gacha {
                    VStack(spacing: 32) {
                        ProgressIndicator(page: self.currentIndex)
                            .padding(.horizontal, 16)
                        Text(self.currentOnboarding.title)
                            .font(.typography(.headline))
                            .foregroundStyle(.tibbyBaseBlack)
                            .multilineTextAlignment(.center)
                        Text(self.currentOnboarding.description)
                            .font(.typography(.body2))
                            .foregroundStyle(.tibbyBaseBlack)
                            .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(.black)
                    if self.currentOnboarding.description != "" {
                        Spacer()
                    }
                }
                switch self.currentOnboarding {
                case .onboarding1:
                    OnboardingView1()
                case .onboarding2:
                    OnboardingView2()
                case .onboarding3:
                    OnboardingView3(name: $name)
                case .onboarding4:
                    OnboardingView4()
                        .onAppear {
                            service.getUser()?.username = name
                        }
                case .gacha:
                    GatchaView(firstTimeHere: $firstTime, currentTibby: $currentTibby)
                        .onAppear(perform: {
                            if let user = service.getUser() {
                                service.updateUser(user: user, username: name)
                            }
                        })
                }
                if self.currentOnboarding != .gacha {
                    Spacer()
                    Button {
                        if self.currentIndex == 1 {
                            if !openHealth {
                                healthManager.authorizationToWriteInHealthStore(action: {
                                    self.nextPage()
                                })
                                openHealth = true
                            }
                            else {
                                self.nextPage()
                            }
                        } else if self.currentIndex == 2 {
                            if !name.isEmpty {
                                self.nextPage()
                            } else {
                                AudioManager.instance.playSFXSecondary(audio: .popup)
                                showingPopUp = true
                            }
                        } else {
                            self.nextPage()
                        }
                        
                        print(self.currentIndex)
                        print(self.currentOnboarding)
                    } label: {
                        HStack {
                            Image(self.currentOnboarding.buttonSymbol)
                                .resizable()
                                .frame(width: 32, height: 32)
                            Text(self.currentOnboarding.buttonLabel)
                                .font(.typography(.title))
                                .foregroundStyle(.tibbyBaseBlack)
                                .padding(.horizontal)
                        }
                    }
                    .buttonPrimary(bgColor: .tibbyBaseBlue)
                }
            }
            .padding(EdgeInsets(top: self.currentOnboarding != .gacha ? 90 : 0, leading: self.currentOnboarding != .gacha ? 16 : 0, bottom: self.currentOnboarding != .gacha ? 30 : 0, trailing: self.currentOnboarding != .gacha ? 16 : 0))
        }
        .ignoresSafeArea(.keyboard)
        .popup(isPresented: $showingPopUp) {
            CustomPopUpView(
                isPresented: $showingPopUp, 
                title: "Provide a Name",
                description: "Please write your name to proceed.",
                actionType: .ok
            )
        }
        .background(.tibbyBaseWhite)
        .onAppear {
            if let user = service.getUser() {
                user.coins = 100
                user.gems = 0
            }
        }
    }
}
    
    
