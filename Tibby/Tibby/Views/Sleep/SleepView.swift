//
//  SleepView.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 16/10/24.

import SwiftUI
import SpriteKit


struct SleepView: View {
    @EnvironmentObject var constants: Constants
    @State var startDate = Date()
    @State private var timeSeconds = 0
    @State private var isRunning = true
    @State private var timer: Timer?
    @State var health = HealthManager()
    @Binding var offset: CGFloat
    var timeGoal  = UserDefaults.standard.value(forKey: "sleep") as? Int ?? 8
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) var scenePhase
    @State private var lastActiveTime: Date?
    @State var tibbyView = TibbyView()
    @EnvironmentObject var service: Service
    var tibby: Tibby
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            pageTitleView
            VStack(alignment: .leading, spacing: 32) {
                startDateView
                timerView
                SleepGoalComponent(goal: timeGoal, title: "Sleep Goal", type: "hours")
                Spacer()
                HStack {
                    Spacer()
                    SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency])
                    Spacer()
                }
            }
            
            customDivider
            
            timerControlButtons
            
            Spacer()
        }
        .padding(32)
        .background(.tibbyBaseBlack)
        .clipShape(
            .rect(
                topLeadingRadius: 45,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 45
            )
        )
        .onAppear {
            startTimer()
            tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
            if constants.tibbySleeping {
                tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
            }
        }
        .onChange(of: scenePhase) {
            handleScenePhaseChange(scenePhase)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all, edges: .bottom)
    }

    private var timerControlButtons: some View {
        HStack(alignment: .center) {
            Button {
                if isRunning {
                    pauseTimer()
                } else {
                    startTimer()
                }
            } label: {
                HStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .foregroundStyle(.black.opacity(0.5))
                        Image(isRunning ? TibbySymbols.pauseWhite.rawValue : TibbySymbols.playWhite.rawValue)
                            .resizable()
                            .scaledToFit()
                            .padding(12)
                    }.frame(maxWidth: 40, maxHeight: 40)
                    Text(isRunning ? "Pause" : "Start")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseWhite)
                }
            }
            
            Spacer()
            
            Button {
                constants.tibbySleeping = false
                constants.showSleepSession = false
                constants.sleeptTime = timeSeconds
                constants.showFinishedSleepSession = true
                stopTimer()
                withAnimation(.easeOut(duration: 0.2)) {
                    offset = UIScreen.main.bounds.height
                    constants.showSleepSession = false
                }
            } label: {
                HStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .foregroundStyle(.black.opacity(0.5))
                        Image(TibbySymbols.squareWhite.rawValue)
                            .resizable()
                            .scaledToFit()
                            .padding(12)
                    }.frame(maxWidth: 40, maxHeight: 40)
                    Text("Finish")
                        .font(.typography(.body))
                        .foregroundStyle(.tibbyBaseWhite)
                }
            }
        }
    }
    
    private var customDivider: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.tibbyBaseGrey)
    }
    
    private var pageTitleView: some View {
        HStack {
            Text("Sleep Tracker")
                .font(.typography(.title))
                .foregroundStyle(.tibbyBaseWhite)
            Spacer()
        }
    }
    
    private var startDateView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Started")
                .font(.typography(.label))
                .foregroundStyle(.tibbyBasePink)
            Text(dateFormatted(startDate))
                .font(.typography(.body))
                .foregroundStyle(.tibbyBaseWhite)
        }
    }
    
    private var timerView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Elapsed time")
                .font(.typography(.body))
                .foregroundStyle(.tibbyBasePink)
            Text(timeFormatted(timeSeconds))
                .font(.typography(.display))
                .foregroundStyle(.tibbyBaseWhite)
        }
    }
    
    func handleScenePhaseChange(_ newPhase: ScenePhase) {
        if newPhase == .background {
            lastActiveTime = Date()
            pauseTimer()
        } else if newPhase == .active, let lastActiveTime {
            let timeInBackground = Date().timeIntervalSince(lastActiveTime)
            timeSeconds += Int(timeInBackground)
            startTimer()
        }
    }
    
    func startTimer() {
        if timer == nil {
            isRunning = true
            startDate = Date()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                timeSeconds += 1
            }
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    func stopTimer() {
        pauseTimer()
        timeSeconds = 0

        // MARK: - TODO: adicionar aqui o salvamento pro healthki
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func dateFormatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm - dd/MM/yyyy"
        return formatter.string(from: date)
    }
}
