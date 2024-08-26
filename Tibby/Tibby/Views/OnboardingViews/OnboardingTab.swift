////
////  OnboardingTab.swift
////  Tibby
////
////  Created by Felipe  Elsner Silva on 07/08/24.
////
//import SwiftUI
//import SpriteKit
//
//struct OnboardingTab: View {
//    @ObservedObject var vm = OnboardingTabViewModel()
//    @Binding var firstTime: Bool
//    @EnvironmentObject var constants: Constants
//    @EnvironmentObject var service: Service
//    @EnvironmentObject var healthManager: HealthManager
//    var animations = OnboardingAnimation()
//    
//    var onboardingView1: some View {
//        VStack {
//            //TODO: change image placeholder
//            SpriteView(scene: animations)
//            
////                    ["https://tibbyappstorage.blob.core.windows.net/onboarding-sprites/Onb1.png,
////                     "https://tibbyappstorage.blob.core.windows.net/onboarding-sprites/Onb2.png"
////                     
////            ]))
//            Rectangle()
//                .frame(width: 300, height: 300)
//        }
//    }
//    
//    var body: some View {
//        ZStack {
//            VStack(alignment: .leading) {
//                HStack {
//                    Button(action: { vm.previousPage() }, label: {
//                        ButtonLabel(type: .secondary, image: TibbySymbols.chevronLeft.rawValue, text: "")
//                    })
//                    .buttonSecondary(bgColor: .black)
//                    .hidden()
//                    
//                    Spacer()
//                }
//                Spacer()
//            }
//            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
//            
//            VStack {
//                VStack {
//                    ProgressIndicator(page: vm.currentIndex)
//                        .padding(.bottom, 16)
//                    
//                    Text(vm.currentOnboarding.title)
//                        .font(.typography(.title))
//                        .multilineTextAlignment(.center)
//                        .lineLimit(nil)
//                    
//                    Text(vm.currentOnboarding.description)
//                        .font(.typography(.label))
//                }
//                .foregroundStyle(.black)
//                
//                // Use the computed property like a variable
//                if vm.currentOnboarding == .onboarding1 {
//                    onboardingView1
//                }
//                
//                Spacer()
//                
//                Button(action: {
//                    handleButtonAction()
//                }, label: {
//                    ButtonLabel(type: .primary, image: constants.currentOnboarding.buttonSymbol, text: constants.currentOnboarding.buttonLabel)
//                })
//                .buttonPrimary(bgColor: .tibbyBaseBlue)
//                .padding(.bottom, 16)
//            }
//            .padding(EdgeInsets(top: 90, leading: 30, bottom: 30, trailing: 30))
//        }
//        .background(.tibbyBaseWhite)
//        .navigationDestination(isPresented: $vm.navigateToGatcha) {
//            HomeView(tibby: service.getAllTibbies().first!)
//        }
//    }
//    
//    private func handleButtonAction() {
//        // Adjust here for any other functions that are necessary
//        if vm.currentIndex == 1 {
//            //TODO: Update for next milestone
//            // healthManager.authorizationToWriteInHealthStore()
//            vm.nextPage()
//        } else if vm.currentIndex == 3 {
//            vm.navigateToGatcha = true
//        } else {
//            vm.nextPage()
//        }
//    }
//}
