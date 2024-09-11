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
    @State var name: String = UserDefaults.standard.value(forKey: "username") as? String ?? ""
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
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
                    OnboardingView3(name: $name)
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
                    } else if vm.currentIndex == 2 {
                        if !name.isEmpty {
                            vm.nextPage()
                        }
                        else {
                           showAlert = true
                        }
                    } else {
                        vm.nextPage()
                    }

                    print(vm.currentIndex)
                    print(vm.currentOnboarding)
                }, label: {
                    HStack {
                        Image(vm.currentOnboarding.buttonSymbol)
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text(vm.currentOnboarding.buttonLabel)
                            .font(.typography(.title))
                            .foregroundStyle(.tibbyBaseBlack)
                            .padding(.horizontal)
                    }

                })
                .buttonPrimary(bgColor: .tibbyBaseBlue)
                .alert(isPresented: $showAlert) {
                    Alert(
                            title: Text("Provide a Name"),
                            message: Text("Please fill the name field before continuing.")
                        )
                    }
            }
            .padding(EdgeInsets(top: 90, leading: 16, bottom: 30, trailing: 16))
        }
        .background(.tibbyBaseWhite)
        .navigationDestination(isPresented: $vm.navigateToGatcha, destination: { GatchaView(firstTimeHere: $firstTime) })
        .onAppear {
            if let user = service.getUser() {
                user.coins = 100
                user.gems = 0
            }
        }
    }
}
