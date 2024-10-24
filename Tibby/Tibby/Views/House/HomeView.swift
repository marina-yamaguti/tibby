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
    @EnvironmentObject var dateManager: DateManager
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.scenePhase) var scenePhase
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
    @State private var showProfile = false
    
    //temporary

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
                    HStack(alignment: .top) {
                        LevelComponent(level: service.getUser()?.level ?? 1)
                            .onTapGesture {
                                HapticManager.instance.impact(style: .soft)
                                AudioManager.instance.playSFX(audio: .secondaryButton)
                                showProfile.toggle()
                            }
                            .navigationDestination(isPresented: $showProfile, destination: {ProfileView(currentTibby: $tibby)})
                        
                        Spacer()
                        
                        Button(action: {showSettings = true}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.gearWhite.rawValue, text: "")})
                            .buttonSecondary(bgColor: .black.opacity(0.5))
                            .navigationDestination(isPresented: $showSettings) {
                                SettingsView()
                            }
                    }
                    .padding(16)
                    Spacer()
                    TibbyNameComponent(name: $tibby.name)
                    
                    TibbyStatusComponent(hunger: tibby.hunger, sleep: tibby.sleep, play: tibby.happiness)
                        .frame(width: 145, alignment: .center)
                        .padding(.bottom, -20)
                    
                    ZStack {
                        SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency]).frame(width: 300, height: 300)
                            .onAppear {
                                tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
                                if constants.tibbySleeping {
                                    if tibby.currentAccessoryId != nil {
                                        tibbyView.removeAccessory {
                                            print("ACCESSORY REMOVED")
                                        }
                                    }
                                    
                                    tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                                } else {
                                    if tibby.currentAccessoryId != nil {
                                        tibbyView.addAccessory(service.getAllAccessories()!.first(where: { a in
                                            a.id == tibby.currentAccessoryId
                                        })!, species: tibby.species) {
                                            print("ACCESSORY ADDED")
                                        } remove: {
                                            print("ACCESSORY REMOVED BEFORE ADD")
                                        }
                                    }
                                    
                                    let tibbySpecie = TibbySpecie(rawValue: tibby.species)
                                    tibbyView.animateTibby((tibby.happiness < 33 || tibby.hunger < 33 || tibby.sleep < 33 ? tibbySpecie?.sadAnimation() : tibbySpecie?.baseAnimation())!, nodeID: .tibby, timeFrame: 0.5)
                                }
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
                            Image(TibbySymbols.playBlack.rawValue)
                                .padding(.trailing, 26)
                            Text("Play")
                                .font(.typography(.title))
                        }
                    }
                    .buttonPrimary(bgColor: .tibbyBaseBlue)
                    .frame(maxHeight: 80)
                    .navigationDestination(isPresented: $navigate) {
                        NavigationTabbarView(vm: NavigationViewModel(tibby: tibby))
                    }
                    
                    HStack(alignment: .center) {
                        Button(action: {showShop = true}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.cartWhite.rawValue, text: "")})
                            .buttonSecondary(bgColor: .black.opacity(0.5))
                            .navigationDestination(isPresented: $showShop) {
                                GatchaView(isBaseOnFocus: true, firstTimeHere: .constant(false), currentTibby: .constant(nil))
                            }
                        Spacer()
                        Button(action: {
                            //showMissionsAlert = true
                            showMissions = true
                        }, label: {ButtonLabel(type: .secondary, image: TibbySymbols.listWhite.rawValue, text: "")})
                        .buttonSecondary(bgColor: .black.opacity(0.5))
                        .navigationDestination(isPresented: $showMissions) {
                            MissionsView()
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
                        .onTapGesture {
                            withAnimation {
                                showSheet.toggle()
                                sheetHeight = 100
                            }
                        }
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
        //Detect if the user is on or off the app
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                print("JORGE Active")
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
                
                //Change the date of today, using the start of the day and start of the week
                if dateManager.lastDayVisited != dateManager.getDay() || dateManager.lastWeekVisited != dateManager.getWeek(){
                    dateManager.setToday()
                }
            }
            else if scenePhase == .inactive {
                print("JORGE Inactive")
            }
            else if scenePhase == .background {
                var missionsDaily = constants.dailyMission.getMissions()

                for i in 0 ..< missionsDaily.count {
                    if missionsDaily[i].missionType == .steps {
                        missionsDaily[i].updateProgress(value: healthManager.stepsDay)
                    }
                }
                constants.dailyMission.missions = missionsDaily
                
                var missionsWeekly = constants.weeklyMission.getMissions()

                for i in 0 ..< missionsWeekly.count {
                    if missionsWeekly[i].missionType == .steps {
                        missionsWeekly[i].updateProgress(value: healthManager.stepsWeek)
                    }
                }
                constants.weeklyMission.missions = missionsWeekly
                
                service.updateMissionsByFrequencyTime(frequencyTime: .day, missions: constants.dailyMission.getMissions())
                service.updateMissionsByFrequencyTime(frequencyTime: .week, missions: constants.weeklyMission.getMissions())
                print("JORGE Background")
            }
        }
        .onAppear(perform: {
            print("home")
            if constants.dailyMission.missions.isEmpty && constants.weeklyMission.missions.isEmpty {
                constants.dailyMission.missions = service.getMissionByFrequencyTime(frequencyTime: .day)
                constants.weeklyMission.missions = service.getMissionByFrequencyTime(frequencyTime: .week)
                
                var missionsDaily = constants.dailyMission.getMissions()
                for i in 0 ..< missionsDaily.count {
                    if missionsDaily[i].missionType == .steps {
                        missionsDaily[i].updateProgress(value: healthManager.stepsDay)
                    }
                    else if missionsDaily[i].missionType == .workout {
                        missionsDaily[i].updateProgress(value: healthManager.workoutTimeDay)
                    }
                }
                constants.dailyMission.missions = missionsDaily
                
                var missionsWeekly = constants.weeklyMission.getMissions()

                for i in 0 ..< missionsWeekly.count {
                    if missionsWeekly[i].missionType == .steps {
                        missionsWeekly[i].updateProgress(value: healthManager.stepsWeek)
                    }
                    if missionsWeekly[i].missionType == .workout {
                        missionsWeekly[i].updateProgress(value: healthManager.workoutTimeWeek)
                    }
                }
                constants.weeklyMission.missions = missionsWeekly
            }
            service.setCurrentTibby(tibbyID: tibby.id)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showSprite = true
            }
            self.dressUpAccessory()
            
            if dateManager.lastDayVisited != dateManager.getDay() || dateManager.lastWeekVisited != dateManager.getWeek(){
                dateManager.setToday()
            }
        })
        .onChange(of: showSheet, {
            print("abir a sheet para mudar de tibby")
            self.dressUpAccessory()
        })
        .onChange(of: self.tibby.currentAccessoryId, {
            print("mudou de acessorio")
            self.dressUpAccessory()
        })
        .onChange(of: dateManager.lastDayVisited) {
            //if the day change, create new missions for the day
            let newMissions: [MissionProtocol] = [
                MissionManager.instance.createMission(dateType: .day, missionType: .feed),
                MissionManager.instance.createMission(dateType: .day, missionType: .workout),
                MissionManager.instance.createMission(dateType: .day, missionType: .sleep),
                MissionManager.instance.createMission(dateType: .day, missionType: .steps)
            ]
            service.updateMissionsByFrequencyTime(frequencyTime: .day, missions: newMissions)
            
            constants.dailyMission.missions = service.getMissionByFrequencyTime(frequencyTime: .day)
        }
        .onChange(of: dateManager.lastWeekVisited) {
            //if the week change, create new missions for the week
            let newMissions: [MissionProtocol] = [
                MissionManager.instance.createMission(dateType: .week, missionType: .feed),
                MissionManager.instance.createMission(dateType: .week, missionType: .workout),
                MissionManager.instance.createMission(dateType: .week, missionType: .sleep),
                MissionManager.instance.createMission(dateType: .week, missionType: .steps)
            ]
            service.updateMissionsByFrequencyTime(frequencyTime: .week, missions: newMissions)
            constants.weeklyMission.missions = service.getMissionByFrequencyTime(frequencyTime: .week)
        }
        
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
