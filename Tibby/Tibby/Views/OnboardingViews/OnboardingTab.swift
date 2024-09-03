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
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            VStack {
                VStack {
                    ProgressIndicator(page: vm.currentIndex)
                        .padding(.bottom, 16)
                    Text(vm.currentOnboarding.title)
                        .font(.typography(.title))
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                    Text(vm.currentOnboarding.description)
                        .font(.typography(.label))

                }
                .foregroundStyle(.black)
                
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
                    //adjust here for any other functions that are necessary
                    if vm.currentIndex == 1 {
                        //TODO: Update for next milestone
//                        healthManager.authorizationToWriteInHealthStore()
                        vm.nextPage()
                    } else if vm.currentIndex == 3 {
                        vm.navigateToGatcha = true
                    }
                    else {
                        vm.nextPage()
                    }
                }, label: {
                    ButtonLabel(type: .primary, image: vm.currentOnboarding.buttonSymbol, text: vm.currentOnboarding.buttonLabel)
                })
                .buttonPrimary(bgColor: .tibbyBaseBlue)
                .padding(.bottom, 16)
            }
            .padding(EdgeInsets(top: 90, leading: 30, bottom: 30, trailing: 30))
        }
        .background(.tibbyBaseWhite)
        .navigationDestination(isPresented: $vm.navigateToGatcha, destination: {HomeView(tibby: service.getAllTibbies().first!)})
    }
}
