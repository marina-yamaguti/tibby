//
//  HomeView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 15/07/24.
//

import SwiftUI
import SpriteKit

struct HomeView: View {
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @EnvironmentObject var healthManager: HealthManager
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var tibby: Tibby
    @State var tibbyView = TibbyView()
    @State var navigate = false
    @State var showSprite = false
    @State var sheetHeight: CGFloat = 100
    @State var arrowUp = true
    @State var showSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        ZStack {
                            SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                                .onAppear {
                                    tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
                                }
                                .opacity(showSprite ? 1 : 0)
                            
                            if !showSprite {
                                Image("\(tibby.species)1")
                                    .resizable()
                                    .frame(width: 300, height: 300)
                            }
                        }.frame(width: 300, height: 300)
                        
                        Button(action: {
                            navigate.toggle()
                        }) {
                            HStack {
                                Image(TibbySymbols.play.rawValue)
                                    .padding(.trailing, 26)
                                Text("Play")
                            }
                        }
                        .buttonPrimary(bgColor: .tibbyBaseBlue)
                        .navigationDestination(isPresented: $navigate) {
                            NavigationTabbarView(vm: NavigationViewModel(tibby: tibby))
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
                VStack {
                    if !showSheet {
                        Spacer()
                        SheetWithCircle(goingUp: arrowUp)
                            .ignoresSafeArea(.all)
                            .frame(height: sheetHeight)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        if !showSheet {
                                            let newHeight = sheetHeight - value.translation.height
                                            sheetHeight = max(100, newHeight)
                                            if sheetHeight > 250 {
                                                withAnimation {
                                                    showSheet.toggle()
                                                    sheetHeight = 100
                                                }
                                            }
                                        }
                                    }
                                    .onEnded { state in
                                        withAnimation {
                                            sheetHeight = 100
                                        }
                                    }
                            )
                    }
                    if showSheet {
                        TibbySelectionView(tibby: $tibby, showSheet: $showSheet)
                            .transition(.move(edge: .bottom))
                            .animation(.bouncy, value: showSheet)
                    }
                }
            }
            .background(
                .tibbyBaseBlue
            )
        }
        .onAppear(perform: {
            print("home")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showSprite = true
            }
            //Decrease the time spent out of the app
            let enteredApp: Bool = UserDefaults.standard.value(forKey: "enteredApp") as? Bool ?? false
            if enteredApp {
                let exitDate: Date = UserDefaults.standard.value(forKey: "exitDate") as? Date ?? .now
                UserDefaults.standard.setValue(false, forKey: "enteredApp")
                
                //calculate the time interval that the user was background
                let interval = abs(exitDate.timeIntervalSince(Date()))
                constants.decreseTibby(tibby: tibby, timeInterval: Double(interval), statusList: [.hungry, .happy, .sleep]) {
                    //save the context of the changes
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    constants.objectWillChange.send()
                }
            }
            //create the timers for each necessity item
            constants.createTimer(tibby: tibby, statusList: [.hungry, .happy, .sleep]) {
                //save the context of the changes
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    constants.objectWillChange.send()
            }
        })
    }
}


