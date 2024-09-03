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
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var tibby: Tibby
    @State var tibbyView = TibbyView()
    @State var navigate = false
    @State var showSprite = false
    @State var sheetHeight: CGFloat = 100
    @State var arrowUp = true
    @State var showSheet = false
    @State private var showShop = false
    @State private var showMissions = false
    @State private var showSettings = false

    
    var body: some View {
        NavigationStack {
            ZStack {
                HStack {
                    Spacer()
                    VStack {
                        HStack(alignment: .center) {
                            LevelComponent(level: 32)
                            Spacer()
                            Button(action: {showSettings = true}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.settingsWhite.rawValue, text: "")})
                                .buttonSecondary(bgColor: .black)
                                .navigationDestination(isPresented: $showSettings) {
                                    SettingsView()
                                }
                        }
                        .padding(16)
                        Spacer()
                        TibbyNameComponent(name: $tibby.name)
                            .padding(.bottom, -20)
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
                                    .font(.typography(.title))
                            }
                        }
                        .buttonPrimary(bgColor: .tibbyBaseBlue)
                        .navigationDestination(isPresented: $navigate) {
                            NavigationTabbarView(vm: NavigationViewModel(tibby: tibby))
                        }
                        
                        HStack(alignment: .center) {
                            Button(action: {showShop = true}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.cart.rawValue, text: "")})
                                .buttonSecondary(bgColor: .black)
                                .navigationDestination(isPresented: $showShop) {
                                    //
                                    GatchaView()
                                }
                            Spacer()
                            Button(action: {showMissions = true}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.list.rawValue, text: "")})
                                .buttonSecondary(bgColor: .black)
                                .navigationDestination(isPresented: $showMissions) {
                                    //
                                }
                        }
                        .padding(16)
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
            if constants.music {
                constants.playMusic(audio: "TibbyHappyTheme")
            }
            print("home")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
            self.dressUpAccessory()
        })
        .onChange(of: showSheet, {
            print("abir a sheet para mudar de tibby")
            self.dressUpAccessory()
        })
        .onChange(of: self.tibby.currentAccessoryId, {
            print("mudou de acessorio")
            self.dressUpAccessory()
        })
    }
    
    private func dressUpAccessory() {
        for accessory in service.getAllAccessories() ?? [] {
            if accessory.id == tibby.currentAccessoryId {
                tibbyView.addAccessory(accessory, species: tibby.species) {
                    service.addAccessoryToTibby(tibbyId: tibby.id, accessory: accessory)
                } remove: {
                    tibbyView.removeAccessory {
                        for accessory in service.getAllAccessories()! {
                            if accessory.id == tibby.currentAccessoryId {
                                service.removeAccessoryFromTibby(accessory: accessory)
                            }
                        }
                    }
                }
                return
            }
        }
        tibbyView.removeAccessory {
            for accessory in service.getAllAccessories()! {
                if accessory.tibbyId == tibby.id {
                    service.removeAccessoryFromTibby(accessory: accessory)
                }
            }
        }
    }
}

