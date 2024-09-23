//
//  OnboardingTab.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//
import SwiftUI

struct OnboardingTab: View {
    @ObservedObject var vm = OnboardingTabViewModel()
    @Binding var firstTime: Bool
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @EnvironmentObject var healthManager: HealthManager
    @State var name: String =  ""
    @State private var showingPopUp = false
    @State private var openHealth = false
    @Binding var currentTibby: Tibby?
    
    var body: some View {
        ZStack {
            if vm.currentOnboarding != .gacha {
                VStack(alignment: .leading) {
                    HStack {
                        if vm.currentIndex == 0 {
                            Button(action: {vm.previousPage()}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.chevronLeftWhite.rawValue, text: "")})
                                .buttonSecondary(bgColor: .black.opacity(0.5))
                                .hidden()
                        } else {
                            Button(action: {vm.previousPage()}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.chevronLeftWhite.rawValue, text: "")})
                                .buttonSecondary(bgColor: .black.opacity(0.5))
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 24))
            }
            VStack {
                if vm.currentOnboarding != .gacha {
                    VStack(spacing: 32) {
                        ProgressIndicator(page: vm.currentIndex)
                            .padding(.horizontal, 16)
                        Text(vm.currentOnboarding.title)
                            .font(.typography(.headline))
                            .foregroundStyle(.tibbyBaseBlack)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                        Text(vm.currentOnboarding.description)
                            .font(.typography(.body2))
                            .foregroundStyle(.tibbyBaseBlack)
                            .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(.black)
                    if vm.currentOnboarding.description != "" {
                        Spacer()
                    }
                }
                switch vm.currentOnboarding {
                case .onboarding1:
                    OnboardingView1()
                        .onAppear {
                            service.createUser(id: UUID(), username: "", level: 1, xp: 0)
                        }
                case .onboarding2:
                    OnboardingView2()
                        .onAppear {
                            openHealth = false
                        }
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
                if vm.currentOnboarding != .gacha {
                    Spacer()
                    Button {
                        if vm.currentIndex == 1 {
                            if !openHealth {
                                healthManager.authorizationToWriteInHealthStore(vm)
                                openHealth = true
                            }
                        } else if vm.currentIndex == 2 {
                            if !name.isEmpty {
                                vm.nextPage()
                            } else {
                                AudioManager.instance.playSFXSecondary(audio: .popup)
                                showingPopUp = true
                            }
                        } else {
                            vm.nextPage()
                        }
                        
                        print(vm.currentIndex)
                        print(vm.currentOnboarding)
                    } label: {
                        HStack {
                            Image(vm.currentOnboarding.buttonSymbol)
                                .resizable()
                                .frame(width: 32, height: 32)
                            Text(vm.currentOnboarding.buttonLabel)
                                .font(.typography(.title))
                                .foregroundStyle(.tibbyBaseBlack)
                                .padding(.horizontal)
                        }
                    }
                    .buttonPrimary(bgColor: .tibbyBaseBlue)
                }
            }
            .padding(EdgeInsets(top: vm.currentOnboarding != .gacha ? 90 : 0, leading: vm.currentOnboarding != .gacha ? 16 : 0, bottom: vm.currentOnboarding != .gacha ? 30 : 0, trailing: vm.currentOnboarding != .gacha ? 16 : 0))
        }
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
    
    
