//
//  FinishedWorkout.swift
//  Tibby
//
//  Created by Sofia Sartori on 12/09/24.
//

import SwiftUI

struct FinishedWorkout: View {
    @Binding var showSheet: Bool
    var timeGoal: Int
    @Binding var workoutSeconds: Int
    var stepsGoal: Int
    @Binding var workoutSteps: Int
    var body: some View {
        VStack {
            HStack {
                Text("Workout Session")
                    .font(.typography(.title))
                    .foregroundStyle(.tibbyBaseWhite)
                Spacer()
                
                Button(action: {
                    showSheet.toggle()
                }, label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(.black.opacity(0.5))
                        Image(TibbySymbols.xMark.rawValue)
                            .resizable()
                            .padding(10)
                    }.frame(width: 40, height: 40)
                })
                
            }.padding()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Overview")
                    .font(.typography(.label))
                    .foregroundStyle(.tibbyBaseGreen)
                
                
                Text("Total Elapsed Time")
                    .font(.typography(.body))
                    .foregroundStyle(.tibbyBaseGreen)
                
                HStack(alignment: .bottom) {
                    Text(self.timeFormatted(workoutSeconds))
                        .font(.typography(.headline))
                        .foregroundStyle(.tibbyBaseWhite)
                    Text("/ \(String(timeGoal)) min")
                        .font(.typography(.label))
                        .foregroundStyle(.tibbyBaseGreen)
                }
                
                Text("Steps Taken")
                    .font(.typography(.body))
                    .foregroundStyle(.tibbyBaseGreen)
                    .padding(.top)
                
                HStack(alignment: .bottom) {
                    Text(String(workoutSteps))
                        .font(.typography(.headline))
                        .foregroundStyle(.tibbyBaseWhite)
                    Text("/ \(String(stepsGoal)) steps")
                        .font(.typography(.label))
                        .foregroundStyle(.tibbyBaseGreen)
                }
                
                Spacer()
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.tibbyBaseGrey)

                HStack {
                    Spacer()
                    Button(action: {
                        self.showSheet.toggle()
                    }, label: {
                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.black.opacity(0.5))
                                Image(TibbySymbols.checkmarkWhite.rawValue)
                                    .resizable()
                                    .padding(12)
                            }.frame(width: 40, height: 40)
                            Text("Done")
                                .foregroundStyle(.tibbyBaseWhite)
                                .font(.typography(.body))
                        }
                    })
                    Spacer()
                }.padding()
            }.padding(.horizontal)
        }.background(.tibbyBaseBlack)
            .withBorderRadius(40)
            .onAppear {
                print("On Finished Workout: ")
                print("steps: \(workoutSteps)")
                print("time: \(workoutSeconds)")
            }
        
        
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

