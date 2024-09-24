//
//  WorkoutMission.swift
//  Tibby
//
//  Created by Sofia Sartori on 11/09/24.
//

import SwiftUI

struct WorkoutMission: View {
    @EnvironmentObject var constants: Constants
    @Binding var showSheet: Bool
    let workout: WorkoutActivityType
    let workoutMissions: [MissionsCollectionProtocol] = []
    var tibby: Tibby
    var body: some View {
        VStack {
            HStack {
                Text(workout.name)
                    .font(.typography(.title))
                    .foregroundStyle(.tibbyBaseWhite)
                Spacer()
                
                Button(action: {
                    showSheet.toggle()
                }, label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(.black.opacity(0.5))
                        Image(TibbySymbols.xmarkWhite.rawValue)
                            .resizable()
                            .padding(10)
                    }.frame(width: 40, height: 40)
                })
                
            }.padding()
            HStack {
                Text("Missions")
                    .font(.typography(.label))
                    .foregroundStyle(.tibbyBaseGreen)
                Spacer()
            }.padding(.horizontal)
            if workoutMissions.isEmpty {
                HStack(alignment: .center) {
                    Spacer()
                    Text("There are no missions attached to this workout type.")
                        .foregroundStyle(.tibbyBaseGrey)
                        .font(.typography(.label))
                        .multilineTextAlignment(.center)
                        .lineSpacing(5.5)
                        .padding(.horizontal, 36)
                        .padding(.vertical, 24)
                    Spacer()
                }.cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.tibbyBaseWhite, lineWidth: 2)
                    )
                    .padding()
            } else {
#warning("wating for mission component")
                //mission component list
            }
            Spacer()
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.tibbyBaseGrey)
                .padding(.horizontal, 16)
            HStack {
                Spacer()
                Button(action: {
                    constants.workout = workout
                    constants.showWorkoutSession = true
//                    WorkoutSessionView(image: "\(tibby.species)1", workout: workhout)
                        
                }, label: {
                    HStack {
                        ZStack {
                            Circle()
                                .foregroundStyle(.black.opacity(0.5))
                            Image(TibbySymbols.playWhite.rawValue)
                                .resizable()
                                .padding(12)
                        }.frame(width: 40, height: 40)
                        Text("Start")
                            .foregroundStyle(.tibbyBaseWhite)
                            .font(.typography(.body))
                    }
                })
                Spacer()
            }.padding()
        }.background(.tibbyBaseBlack)
            .withBorderRadius(40)
        
    }
}

