//
//  WorkoutSession.swift
//  Tibby
//
//  Created by Sofia Sartori on 05/09/24.
//
import SwiftUI

struct WorkoutSessionView: View {
    let image: String
    let workout: WorkoutActivityType
    
    @EnvironmentObject var constants: Constants
    @State var startDate = Date()
    @State var stepsStart: Int = 0
    @State private var timeSeconds = 0
    @State private var isRunning = true
    @State private var timer: Timer?
    @State var steps: Int = 0
    @State var health = HealthManager()
    @State var workoutList: [WorkoutPraticInterval] = []
    @Binding var offset: CGFloat
    var stepsGoal: Int
    var timeGoal: Int

    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) var scenePhase
    
    @State private var lastActiveTime: Date?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(workout.name)
                    .font(.typography(.title))
                    .foregroundStyle(.tibbyBaseWhite)
                Spacer()
            }.padding(.horizontal)
                .padding(.top, 32)
                .padding(.bottom)
            VStack(alignment: .leading, spacing: 20) {
                Text("Elapsed Time")
                    .font(.typography(.body))
                    .foregroundStyle(.tibbyBaseGreen)
                Text(timeFormatted(timeSeconds))
                    .font(.typography(.display))
                    .foregroundStyle(.tibbyBaseWhite)
                Text("Steps Taken")
                    .font(.typography(.body))
                    .foregroundStyle(.tibbyBaseGreen)
                Text(String(steps))
                    .font(.typography(.display))
                    .foregroundStyle(.tibbyBaseWhite)
                WorkoutComponent(goal: timeGoal, title: "Exercise goal", type: "min")
                WorkoutComponent(goal: stepsGoal, title: "Steps goal", type: "steps")

            }.padding(.horizontal, 32)
            HStack {
                Spacer()
                ZStack {
                    Image("WorkoutMat")
                        .resizable()
                        .scaledToFit()
                    Image(image)
                        .resizable()
                        .scaledToFit()
                    
                }.padding()
                Spacer()
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.tibbyBaseGrey)
                .padding(.horizontal, 36)
            
            HStack(alignment: .center) {
                Button(action: {
                    if isRunning {
                        pauseTimer()
                    } else {
                        startTimer()
                    }
                }, label: {
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
                })
                Spacer()
                Button(action: {
                    constants.workoutSteps = steps
                    constants.workoutSeconds = timeSeconds
                    constants.showFinishedWorkout = true
                    stopTimer()
                    withAnimation(.easeOut(duration: 0.2), {
                        offset = UIScreen.main.bounds.height
                        constants.showWorkoutSession = false
                    })
                    
                }, label: {
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
                })
                
            }.padding(.horizontal, 36)
                .padding(.vertical)
            Spacer()
                
            
        }.background(.tibbyBaseBlack)
            .clipShape(
                .rect(
                    topLeadingRadius: 45,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 45
                )
            )
            .onAppear {
                health.fetchInformation(informationList: [(dateInfo: .startOfDay, sampleInfo: .steps, dataTypeInfo: .day)])
                startTimer()
            }
            .onChange(of: scenePhase) { newPhase in
                handleScenePhaseChange(newPhase)
            }
            .navigationBarBackButtonHidden(true)
        
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
                
                health.fetchInformation(informationList: [(dateInfo: .startOfDay, sampleInfo: .steps, dataTypeInfo: .day)])
                
                if stepsStart == 0 {
                    stepsStart = health.stepsDay
                }
                
                steps = (health.stepsDay - stepsStart)
            }
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        workoutList.append(WorkoutPraticInterval(start: startDate, end: Date(), activity: workout))
    }
    
    func stopTimer() {
        pauseTimer()
        timeSeconds = 0
        health.saveWorkout(workout: WorkoutPratic(intervals: workoutList))
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
