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
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    if vm.currentIndex == 0 {
                        Button(action: {vm.previousPage()}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.chevronLeft.rawValue, text: "")})
                            .buttonSecondary(bgColor: .black)
                            .hidden()
                    } else {
                        Button(action: {vm.previousPage()}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.chevronLeft.rawValue, text: "")})
                            .buttonSecondary(bgColor: .black)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 24))
            
            VStack {
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
                
                switch vm.currentOnboarding {
                case .onboarding1:
                    OnboardingView1()
                case .onboarding2:
                    OnboardingView2()
                case .onboarding3:
                    OnboardingView3()
                case .onboarding4:
                    OnboardingView4()
                
                }
                Spacer()
                Button(action: {
                    if vm.currentIndex == 1 {
                        healthManager.authorizationToWriteInHealthStore()
                        vm.nextPage()
                    } else if vm.currentIndex == 3 {
                        vm.navigateToGatcha = true
                    }
                    else {
                        vm.nextPage()
                    }

                    print(vm.currentIndex)
                    print(vm.currentOnboarding)
                }, label: {
                    ButtonLabel(type: .primary, image: vm.currentOnboarding.buttonSymbol, text: vm.currentOnboarding.buttonLabel)

                })
                .buttonPrimary(bgColor: .tibbyBaseBlue)
                .padding(32)
            }
            .padding(EdgeInsets(top: 90, leading: 16, bottom: 30, trailing: 16))
        }
        .background(.tibbyBaseWhite)
        .navigationDestination(isPresented: $vm.navigateToGatcha, destination: { GatchaView(firtTimeHere: firstTime) })
        .onAppear {
            if let user = service.getUser() {
                user.coins = 100
                user.gems = 0
            }
        }
    }
}
